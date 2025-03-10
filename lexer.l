%{
#include "parser.tab.h"
#include <string.h>
%}

%%

[ \t\n]+            ;  // Ignore whitespace
"ank"              { return INT; }
"bool"             { return BOOL; }
"sachu"            { return TRUE; }
"khotu"            { return FALSE; }
"khali"            { return VOID; }
"chhapo"           { return PRINTF; }
"athva"            { return OR; }
"jo"              { return IF; }
"ane"             { return AND; }
"toh"             { return THEN; }
"nahito"          { return ELSE; }
"fervo"           { return FOR; }
"moklo"           { return RETURN; }
"shes"            { return MOD; }
"vakya"           { return STRING; }
"bandharan"       { return STRUCT; }

\"[^\"]*\"         { yylval.sval = strdup(yytext); return STRING; }  // Properly capture strings
[0-9]+             { yylval.ival = atoi(yytext); return NUMBER; }
[a-zA-Z_][a-zA-Z0-9_]* { yylval.sval = strdup(yytext); return IDENTIFIER; }

"="                { return ASSIGN; }
"("                { return LPAREN; }
")"                { return RPAREN; }
"{"                { return LBRACE; }
"}"                { return RBRACE; }
";"                { return SEMICOLON; }
"<"                { return LESS; }
">"                { return GREATER; }
"%"                { return MOD; }
"+"                { return PLUS; }
"-"                { return MINUS; }
"*"                { return MUL; }
"/"                { return DIV; }

.                  { printf("Unrecognized character: %s\n", yytext); }

%%

int yywrap() { return 1; }
