compiler: parser.tab.o lex.yy.o
	gcc -o compiler parser.tab.o lex.yy.o -ll

parser.tab.c parser.tab.h: parser.y
	bison -d parser.y

lex.yy.c: lexer.l
	flex lexer.l

parser.tab.o: parser.tab.c
	gcc -c parser.tab.c

lex.yy.o: lex.yy.c
	gcc -c lex.yy.c

clean:
	rm -f compiler *.o parser.tab.* lex.yy.c
