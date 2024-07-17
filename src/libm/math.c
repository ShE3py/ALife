#include "math.h"

// HACK: clang doesn't allow adding attributes on builtin functions
__attribute__((import_name("cosf"), import_module("libm")))
float cosf_hack(float x);

float cosf(float x) {
    return cosf_hack(x);
}

float fabsf(float x) {
    return x <= -0.0 ? -x : x;
}

