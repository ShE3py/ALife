CC = gcc
CFLAGS = -Wpedantic -Wall -Wextra -Wno-unused -fanalyzer -g -Iglad/include
LFLAGS = -lglfw

physarum: out/gl.o out/main.o out/codec.o
	gcc $(CFLAGS) $(LFLAGS) $^ -o $@

out/main.o: src/main.c src/codec.h
	gcc $(CFLAGS) -c $< -o $@

out/codec.o: src/codec.c src/codec.h
	gcc $(CFLAGS) -c $< -o $@

out/gl.o: glad/src/gl.c
	gcc $(CFLAGS) -c $< -o $@

clean:
	rm -rf out/*

video:
	ffmpeg -framerate 60 -pattern_type glob -i 'frame/*.ppm' -c:v libx264 -crf 17 -tune stillimage physarum.mp4

