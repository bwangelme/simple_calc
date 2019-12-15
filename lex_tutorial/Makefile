.PHONY: test

lex: lex.l
	/usr/local/Cellar/flex/2.6.4_1/bin/flex lex.l
	cc lex.yy.c -o lex -ll
test: lex
	./lex test1.p
