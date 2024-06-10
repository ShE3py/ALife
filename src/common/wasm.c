#include "wasm.h"

EXPORT("fprintf")
int fprintf(FILE *stream, const char *format, ...) {
    return 0;
}

EXPORT("printf")
int printf(const char *format, ...) {
    return 0;
}

EXPORT("perror")
void perror(const char *s) {}

EXPORT("malloc")
void* malloc(size_t n) {
    extern unsigned char __heap_base;
    static size_t bump_pointer = (size_t) &__heap_base;
    
    size_t r = bump_pointer;
    bump_pointer += n;
    return (void*) r;
}

EXPORT("free")
void free(void *p) {}

