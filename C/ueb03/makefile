
all	: ueb07


ueb07   : ueb07.o bstring.o
	gcc -lm  -o uebung ueb03.o bstring.o
	
ueb07.o	: ueb07.c bstring.h
	gcc -Wall -Werror -ansi -pedantic -c ueb07.c
	
bstring.o	: bstring.c bstring.h
	gcc -ansi -pedantic -Wall -Werror -c bstring.c


gcc -ansi -pedantic -Wall -Werror -c bstring.c
ar rc libbstring.a bstring.o
gcc -ansi -pedantic -Wall -Werror main.c -L. -lbstring -o ueb07
