#include "stdio.h"

#include <string.h>

__attribute__((import_name("fprint"), import_module("libc")))
void fprint(FILE *restrict stream, const char *restrict s, size_t n);

int vfprintf(FILE *restrict stream, const char *restrict format, va_list ap) {
    if(stream != stdout && stream != stderr) {
        return 0;
    }
    
    size_t n = strlen(format);
    fprint(stream, format, n);
    return n + 1;
}

int fprintf(FILE *restrict stream, const char *restrict format, ...) {
    va_list args;
    va_start(args, format);
    int r = vfprintf(stream, format, args);
    va_end(args);
    return r;
}

int printf(const char *restrict format, ...) {
    va_list args;
    va_start(args, format);
    int r = vfprintf(stdout, format, args);
    va_end(args);
    return r;
}

void perror(const char *s) {
    fprint(stderr, s, strlen(s));
}

