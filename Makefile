CC = clang
CFLAGS = -Wpedantic -Wall -Wextra -Wno-unused-parameter -g3 -Ofast -Isrc
LFLAGS = -Lout -lcommon

default: elf

elf: CFLAGS := $(CFLAGS) -Iglad/include
elf: LFLAGS := $(LFLAGS) -lglfw -lwindow
elf: out/libwindow.a physarum autopoiesis gray-scott

wasm: TFLAGS := --target=wasm32 -nostdlib
wasm: CFLAGS := $(TFLAGS) $(CFLAGS) -Isrc/libc -Isrc/libm
wasm: LFLAGS := -Wl,--no-entry $(LFLAGS) -lc
wasm: out/libc.a out/libm.a physarum gray-scott

physarum: out/physarum/main.o out/physarum/config.o
	$(CC) $(TFLAGS) $^ $(LFLAGS) -o $@

autopoiesis: out/autopoiesis/main.o out/autopoiesis/config.o
	$(CC) $(TFLAGS) $^ $(LFLAGS) -lm -o $@

gray-scott: out/gray-scott/main.o out/gray-scott/config.o out/gray-scott/xmorphia.o
	$(CC) $(TFLAGS) $^ $(LFLAGS) -lm -o $@

out/libcommon.a: out/common/main.o out/common/shader.o out/common/snap.o
	llvm-ar rcs $@ $^

out/libwindow.a: out/glad.o out/common/window.o
	llvm-ar rcs $@ $^

out/libc.a: out/libc/stdlib.o out/libc/stdio.o out/libc/string.o
	llvm-ar rcs $@ $^

out/libm.a: out/libm/math.o
	llvm-ar rcs $@ $^

out/%/main.o: src/%/main.c src/%/config.c out/libcommon.a
	$(CC) $(CFLAGS) -c $< -o $@

out/%.o: src/%.c src/%.h
	$(CC) $(CFLAGS) -c $< -o $@

out/glad.o: glad/src/gl.c
	$(CC) $(CFLAGS) -c $< -o $@

out/%/config.o: src/%/config.c
	$(CC) $(CFLAGS) -Duint="unsigned int" -Dbool="_Bool" -Dtrue="1" -Dfalse="0" -c $< -o $@

src/common/lib.c: src/common/lib.h
src/common/shader.c: src/common/shader.h

clean:
	rm -rf out/*
	mkdir -p out/common
	mkdir -p out/libc
	mkdir -p out/libm
	mkdir -p out/physarum
	mkdir -p out/autopoiesis
	mkdir -p out/gray-scott

video:
	ffmpeg -framerate 240 -pattern_type glob -i 'frame/*.ppm' -c:v libx264 -crf 20 -preset veryslow -tune stillimage gray-scott.mp4

