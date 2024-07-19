#include "math.h"

// HACK: clang doesn't allow adding attributes on builtin functions
__attribute__((import_name("cosf"), import_module("libm"))) float cosf_hack(float x);
__attribute__((import_name("fmodf"), import_module("libm"))) float fmodf_hack(float x, float y);

float cosf(float x) {
    return cosf_hack(x);
}

float fabsf(float x) {
    return x <= -0.0 ? -x : x;
}

float fmaxf(float x, float y) {
    return x >= y ? x : y;
}

float fmodf(float x, float y) {
    return fmodf_hack(x, y);
}

float modff(float x, float *iptr) {
    float f = fmodf(x, 1.0);
    *iptr = x - f;
    
    return f;
}

