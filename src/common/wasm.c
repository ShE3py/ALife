#ifdef __wasm__

#include "wasm.h"

#include <stdarg.h>

EXPORT("printf")
int printf(const char *format, ...) {
    va_list args;
    va_start(args, format);
    int r = fprintf(stdout, format, args);
    va_end(args);
    return r;
}

EXPORT("perror")
void perror(const char *s) {
    fprintf(stderr, s);
}

IMPORT("grow")
void grow(size_t);

EXPORT("malloc")
void* malloc(size_t n) {
    extern unsigned char __heap_base;
    static size_t bump_pointer = (size_t) &__heap_base;
    static size_t pages = 1;
    
    size_t available = (pages * 65536) - ((size_t) &__heap_base - bump_pointer);
    if(available < n) {
        size_t needed = (n + 65535) / 65536;
        grow(2 * needed);
    }
    
    size_t ptr = bump_pointer;
    bump_pointer += n;    
    return (void*) ptr;
}

EXPORT("free")
void free(void *p) {}

#else
#include "../glad/src/gl.c"
#endif // __wasm__

