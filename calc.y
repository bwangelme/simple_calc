%token   INTEGER
%left    '+' '-'
%left    '*' '/'

%{
    #include <stdio.h>
    void yyerror(char*);
    int yylex(void);

    int sym[26];
%}

%%
program:
    program expr '\n' { printf("%d\n", $2)}
    |
    ;
expr:
    expr '+' term { $$ = $1 + $3; }
    | term
    ;
term:
    term '*' factor { $$ = $1 * $3; }
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
