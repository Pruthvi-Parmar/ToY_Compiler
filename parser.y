%{
#include <stdio.h>
#include <stdlib.h>
#include "ast.h"

void yyerror(const char *s);
int yylex();
int yyparse();  // Declare yyparse()

%}

%union {
    int ival;
    char *sval;
    struct ASTNode *node;
}

/* Tokens */
%token <sval> IDENTIFIER STRING
%token <ival> NUMBER
%token INT BOOL TRUE FALSE VOID PRINTF OR IF AND THEN ELSE FOR RETURN MOD STRUCT

/* Non-Terminals */
%type <node> statement program

%%

program:
    program statement
    | statement
    ;

statement:
    INT IDENTIFIER ';'  { printf("Declared integer variable: %s\n", $2); }
    | BOOL IDENTIFIER ';' { printf("Declared boolean variable: %s\n", $2); }
    | PRINTF '(' STRING ')' ';' { printf("Print statement with string: %s\n", $3); }
    | IF '(' IDENTIFIER ')' THEN statement ELSE statement
    | RETURN NUMBER ';' { printf("Return statement with value: %d\n", $2); }
    ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main() {
    printf("Enter code:\n");
    return yyparse();
}
