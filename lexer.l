%{
#include "parser.tab.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
%}

%%
"ank"        return INT;
"bool"       return BOOL;
"sachu"      return TRUE;
"khotu"      return FALSE;
"khali"      return VOID;
"chhapo"     return PRINTF;
"athva"      return OR;
"jo"         return IF;
"ane"        return AND;
"toh"        return THEN;
"nahito"     return ELSE;
"fervo"      return FOR;
"moklo"      return RETURN;
"shes"       return MOD;
"vakya"      return STRING;
"bandharan"  return STRUCT;

[0-9]+       { yylval.ival = atoi(yytext); return NUMBER; }
[a-zA-Z_][a-zA-Z0-9_]* { yylval.sval = strdup(yytext); return IDENTIFIER; }

\"[^\"]*\"   { yylval.sval = strdup(yytext); return STRING; } // Fix for strings

[ \t\n]+     /* Ignore whitespace */
.            { return yytext[0]; }  // Return character as a token

%%

int yywrap() {
    return 1;
}
