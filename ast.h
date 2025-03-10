#ifndef AST_H
#define AST_H

typedef struct ASTNode {
    char *type;
    char *value;
} ASTNode;

ASTNode *createNode(char *type, char *value);
void printAST(ASTNode *node);

#endif
