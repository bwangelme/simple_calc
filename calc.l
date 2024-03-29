%option noyywrap

%{
    /*
     *  一个简单计算器的Lex词法文件
     */
    void yyerror(char*);
    #include "calc.tab.h"
%}

%%

	/* 整数 */
[0-9]+ {
	yylval = atoi(yytext);
	return INTEGER;
}

	/* 运算符 */
[-+] {
    yylval = *yytext;
    return OP1;
}
[*/] {
    yylval = *yytext;
    return OP2;
}

	/* 运算符 */
[()=\n]    {return *yytext;}

	/* 空白被忽略 */
[ \t]    ;

    /* 注释 */
#.*  ;

	/* 其他字符都是非法的 */
. yyerror("invalid input");

%%
