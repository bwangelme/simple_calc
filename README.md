基于 Flex 和 Bison 简单计算器
=========

## 说明

这是一个支持加法，乘法，括号的简单计算器

## 文法

```
Program -> Program Expr '\n'|空集合
Expr -> Expr + Term | Factor
Term -> Term * Factor | F
Factor -> ( Expr ) | INTEGER
```

其中 Program 是开始符号，INTEGER 是终结符号，其余的都是非终结符号。

## 在 Mac 下编译并执行

```sh
$make
$./calc < input.txt
A simple calculator.
23
25
# 也可以自己输入其他算术表达式查看结果
```

## 在 Windows 下编译

### 准备工作

1. 从 [lexxmark/winflexbison](https://github.com/lexxmark/winflexbison/releases) 下载最新版的 flex 及 bison 编译器。
2. 将 `win_flex.exe` 和 `win_bison.exe` 这两个可执行文件所在文件夹加到环境变量 `PATH` 中。

### 词法分析

词法分析就是根据 `calc.l` 文件中定义的规则，将用户输入的字符串解析成 Token 流。

在这个程序中，我们只定义了一个 Token: `INTEGER`。注意，`INTEGER`是在`calc.y`中定义的，我们在执行语法分析的时候添加了`-d`选项，这个会将 TOKEN 输出到 `calc.tab.h` 中，然后在语法分析程序中引用了这个头文件。

生成词法分析程序的命令如下，程序正确执行后，会生成 `lex.yy.c` 文件。词法分析的具体程序都在 `lex.yy.c` 中实现了。

```sh
# --nounistd 表示不再源文件中包含 unistd.h 头文件
win_flex.exe --nounistd calc.l
# 输出 lex.yy.c 文件
```

### 语法分析

语法分析就是根据 `calc.y` 中定义的文法，实现计算器的计算功能。生成语法分析程序的命令如下:

```sh
# -d 表示也会输出定义文件/.h文件
win_bison.exe -d calc.y
# 输出 calc.tab.c calc.tab.h
```

我们在 calc.y 的辅助性 c 语言程序部分定义了一个`main`函数，最终编译成的可执行文件就会从`main`函数开始执行，我们在`main`中调用了`yyparse`函数，这个函数开始执行语法分析程序。

### 生成可执行文件

打开 Visual C++，新建一个项目，将 `calc.tab.c` 和 `lex.yy.c` 加到源文件中，将 `calc.tab.h` 加到头文件中，编译，就可以生成最终的可执行文件了。
