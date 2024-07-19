#ifndef __wasm__
#   error
#endif // !__wasm__

#ifndef LIBM_MATH_H
#define LIBM_MATH_H

float cosf(float x);
float fabsf(float x);

float fmaxf(float x, float y);

float fmodf(float x, float y);
float modff(float x, float *iptr);

// Those calls are actually optimized out
__attribute__((import_name("floorf"), import_module("libm"))) float floorf(float x);
__attribute__((import_name("sqrtf"), import_module("libm"))) float sqrtf(float x);

#endif // LIBM_MATH_H

