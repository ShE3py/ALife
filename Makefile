CC = gcc
CFLAGS = -Wpedantic -Wall -Wextra -Wno-unused -fanalyzer -g -Iglad/include
LFLAGS = -lglfw

physarum: out/gl.o out/main.o
	gcc $(CFLAGS) $(LFLAGS) $^ -o $@

out/main.o: src/main.c
	gcc $(CFLAGS) -c $< -o $@

out/gl.o: glad/src/gl.c
	gcc $(CFLAGS) -c $< -o $@

clean:
	rm -rf out/*

