CC = gcc
CFLAGS = -Wall -Wextra -I.  # Include current directory

all: compiler

compiler: parser.tab.o lex.yy.o ast.o
	$(CC) $(CFLAGS) -o compiler parser.tab.o lex.yy.o ast.o -ll

parser.tab.c parser.tab.h: parser.y
	bison -d parser.y

lex.yy.c: lexer.l parser.tab.h  # Ensure lexer.l exists
	flex lexer.l

parser.tab.o: parser.tab.c
	$(CC) $(CFLAGS) -c parser.tab.c

lex.yy.o: lex.yy.c
	$(CC) $(CFLAGS) -c lex.yy.c

ast.o: ast.c ast.h
	$(CC) $(CFLAGS) -c ast.c

clean:
	rm -f compiler *.o parser.tab.* lex.yy.c
