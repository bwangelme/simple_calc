%token   INTEGER OP1 OP2

%{
    #include <stdio.h>
    void yyerror(char*);
    int yylex(void);

    int sym[26];
%}

%%
program:
    program expr '\n' { printf("%d\n", $2); }
    |
    ;
expr:
    expr OP1 term {
        switch($2) {
        case '+':
            $$ = $1 + $3;
            break;
        case '-':
            $$ = $1 - $3;
            break;
        }
    }
    | term
    ;
term:
    term OP2 factor {
        switch($2) {
        case '*':
            $$ = $1 * $3;
            break;
        case '/':
            $$ = $1 / $3;
            break;
        }
    }
    | factor
    ;
factor:
    '(' expr ')' { $$ = $2; }
    | INTEGER
    ;
%%

void yyerror(char* s)
{
    fprintf(stderr, "%s\n", s);
}

int main(void)
{
    printf("A simple calculator.\n");
    yyparse();
    return 0;
}
