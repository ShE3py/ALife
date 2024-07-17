#ifndef COMMON_MAIN_H
#define COMMON_MAIN_H

#include "gl.h"

#ifdef __wasm__
#   define EXPORT(n) __attribute__((export_name(n)))
#else
#   define EXPORT(n)
#endif // !__wasm__

void create_rcx(void);
void setup(float *frame, GLprogram renderer, GLprogram simulator);
void main_loop(void);

EXPORT("reset_frame")
void reset_frame(void);

#endif // COMMON_MAIN_H

