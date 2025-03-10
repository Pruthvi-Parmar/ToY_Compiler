%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void yyerror(const char *s);
int yylex();
int yyparse();
%}

%union {
    int ival;
    char *sval;
}

%token <sval> IDENTIFIER STRING
%token <ival> NUMBER
%token INT BOOL TRUE FALSE VOID PRINTF OR IF AND THEN ELSE FOR RETURN MOD STRUCT
%token ASSIGN PLUS MINUS MUL DIV SEMICOLON LPAREN RPAREN LBRACE RBRACE LESS GREATER

%type <sval> assignment for_loop
%type <ival> expression

%%

program:
    program statement
    | statement
    ;

statement:
    INT IDENTIFIER SEMICOLON { printf("Declared integer variable: %s\n", $2); }
    | BOOL IDENTIFIER SEMICOLON { printf("Declared boolean variable: %s\n", $2); }
    | PRINTF LPAREN STRING RPAREN SEMICOLON { 
        printf("Print statement: %s\n", $3); 
    }
    | assignment SEMICOLON { printf("Assignment: %s\n", $1); }
    | for_loop { }
    | RETURN expression SEMICOLON { printf("Return statement: %d\n", $2); }
    ;

assignment:
    IDENTIFIER ASSIGN expression {
        char buffer[100];
        snprintf(buffer, sizeof(buffer), "%s = %d", $1, $3);
        $$ = strdup(buffer);
    }
    ;

expression:
    NUMBER { $$ = $1; }
    | expression PLUS expression { $$ = $1 + $3; }
    | expression MINUS expression { $$ = $1 - $3; }
    | expression MUL expression { $$ = $1 * $3; }
    | expression DIV expression { $$ = $1 / $3; }
    | expression MOD expression { $$ = $1 % $3; }
    ;

for_loop:
    FOR LPAREN assignment SEMICOLON expression SEMICOLON assignment RPAREN LBRACE statement_list RBRACE {
        printf("For loop: Initialization [%s], Condition [%d], Increment [%s]\n", $3, $5, $7);
    }
    ;

statement_list:
    statement
    | statement_list statement
    ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main() {
    printf("Enter code (Press Ctrl+D to end input):\n");
    return yyparse();
}
