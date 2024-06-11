CC = clang --target=wasm32 -nostdlib -Wl,--no-entry
CFLAGS = -Wpedantic -Wall -Wextra -Wno-unused -g -Iglad/include -Isrc
LFLAGS = -Lout -lcommon

all: physarum autopoiesis

physarum: out/physarum/main.o out/physarum/config.o
	$(CC) $(CFLAGS) $^ $(LFLAGS) -o $@
	
autopoiesis: out/autopoiesis/main.o out/autopoiesis/config.o
	$(CC) $(CFLAGS) $^ $(LFLAGS) -lm -o $@

out/libcommon.a: out/common/lib.o out/common/shader.o out/common/snap.o out/common/wasm.o
	llvm-ar rcs $@ $^

out/%/main.o: src/%/main.c src/%/config.c out/libcommon.a
	$(CC) $(CFLAGS) -c $< -o $@

out/%.o: src/%.c src/%.h
	$(CC) $(CFLAGS) -c $< -o $@

out/%/config.o: src/%/config.c
	$(CC) $(CFLAGS) -Duint="unsigned int" -Dbool="_Bool" -Dtrue="1" -Dfalse="0" -c $< -o $@

src/common/lib.c: src/common/lib.h
src/common/shader.c: src/common/shader.h

clean:
	rm -rf out/*
	mkdir -p out/common
	mkdir -p out/physarum
	mkdir -p out/autopoiesis

video:
	ffmpeg -framerate 60 -pattern_type glob -i 'frame/*.ppm' -c:v libx264 -crf 20 -preset veryslow -tune stillimage autopoiesis.mp4

