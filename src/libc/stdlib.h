#ifndef __wasm__
#   error
#endif // !__wasm__

#ifndef LIBC_STDLIB_H
#define LIBC_STDLIB_H

#include <inttypes.h>

// Types
#define NULL ((void*) 0)

// Alloc
void* malloc(size_t size);
void free(void *ptr);

// Runtime
_Noreturn void exit(int status);

// Random
#define RAND_MAX 2147483647

__attribute__((import_name("rand"), import_module("libc")))
int rand(void);
void srand(unsigned int seed);

#endif // LIBC_STDLIB_H

