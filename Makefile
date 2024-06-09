CC = gcc
CFLAGS = -Wpedantic -Wall -Wextra -Wno-unused -fanalyzer -g -Iglad/include
LFLAGS = -lglfw -Lout -lcommon

physarum: out/libcommon.a out/main.o out/config.o
	gcc $(CFLAGS) $^ $(LFLAGS) -o $@

out/libcommon.a: out/common/lib.o out/common/shader.o out/gl.o
	ar rcs $@ $^

out/%.o: src/%.c src/%.h
	gcc $(CFLAGS) -c $< -o $@

out/gl.o: glad/src/gl.c
	gcc $(CFLAGS) -c $< -o $@

out/config.o: src/config.c
	gcc $(CFLAGS) -Duint="unsigned int" -Dbool="_Bool" -Dtrue="1" -Dfalse="0" -c $< -o $@

src/main.c: src/config.h

src/common/lib.c: src/common/lib.h
src/common/shader.c: src/common/shader.h

clean:
	rm -rf out/*

video:
	ffmpeg -framerate 60 -pattern_type glob -i 'frame/*.ppm' -c:v libx264 -crf 20 -preset veryslow -tune stillimage physarum.mp4

