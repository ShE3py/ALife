#include "stdlib.h"

__attribute__((import_name("grow"), import_module("libc")))
void grow(size_t pages);

void* malloc(size_t n) {
    extern unsigned char __heap_base;
    static size_t bump_pointer = (size_t) &__heap_base;
    static size_t pages = 1;
    
    size_t available = (pages * 65536) - ((size_t) &__heap_base - bump_pointer);
    if(available < n) {
        size_t needed = (n + 65535) / 65536;
        size_t growth = 2 * needed;
        grow(growth);
        pages += growth;
    }
    
    size_t ptr = bump_pointer;
    bump_pointer += n;    
    return (void*) ptr;
}

void free(void *ptr) {}

_Noreturn void exit(int status) {
    __builtin_trap();
}

void srand(unsigned int seed) {}

