#ifndef __wasm__
#   error
#endif // !__wasm__

#ifndef LIBC_STDIO_H
#define LIBC_STDIO_H

#include <inttypes.h>
#include <stdarg.h>

typedef int FILE;

#define stdout ((FILE*) 0)
#define stderr ((FILE*) 1)

int vfprintf(FILE *restrict stream, const char *restrict format, va_list ap);
int fprintf(FILE *restrict stream, const char *restrict format, ...);
int printf(const char *restrict format, ...);
void perror(const char *s);

#endif // LIBC_STDIO_H

