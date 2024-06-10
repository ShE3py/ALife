#ifndef COMMON_LIB_H
#define COMMON_LIB_H

#include "wasm.h"

void set_size(int w, int h);

#ifndef __wasm__
void init(const char *title);
#endif

void setup(float *initial_frame, GLuint renderer, GLuint simulator);
void main_loop();
void uninit();

#endif // COMMON_LIB_H

