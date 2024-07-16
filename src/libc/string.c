#include "string.h"

size_t strlen(const char *s) {
    const char *t = s;
    
    while(*t != '\0') {
        ++t;
    }
    
    return t - s;
}

