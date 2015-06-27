
all	: uebung


uebung	: ueb04.o glAusgabe.o Matrix3.o
	gcc -lm -lglut -lGL -o uebung ueb04.o glAusgabe.o Matrix3.o
	
ueb04.o	: ueb04.c glAusgabe.h
	gcc -Wall -Werror -ansi -pedantic -c ueb04.c
	
matrix3.o	: Matrix3.c Matrix3.h
	gcc -Wall -Werror -ansi -pedantic -c Matrix3.c
	
glAusgabe.o	: glAusgabe.c glAusgabe.h
	gcc -Wall -Werror -ansi -pedantic -c glAusgabe.c
