#ifndef COMMON_LIB_H
#define COMMON_LIB_H

#include "gl.h"

#ifdef __wasm__
#   define EXPORT(n) __attribute__((export_name(n)))
#else
#   define EXPORT(n)
#endif // !__wasm__

void set_size(int w, int h);

void create_rcx(void);
void setup(float *initial_frame, GLprogram renderer, GLprogram simulator);
void main_loop(void);

#endif // COMMON_LIB_H

