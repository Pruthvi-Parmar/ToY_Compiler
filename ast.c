#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "ast.h"

ASTNode *createNode(char *type, char *value) {
    ASTNode *node = (ASTNode *)malloc(sizeof(ASTNode));
    node->type = strdup(type);
    node->value = strdup(value);
    return node;
}

void printAST(ASTNode *node) {
    if (node) {
        printf("AST Node -> Type: %s, Value: %s\n", node->type, node->value);
    }
}
