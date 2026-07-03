allrun: all run

all:
	@gcc Jogo.c -o main -g  -std=c99 -Wall -lm

run:
	@./main