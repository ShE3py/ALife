#ifndef COMMON_LIB_H
#define COMMON_LIB_H

#include <stdint.h>

typedef uint32_t GLuint;

void set_size(int w, int h);
void init(const char *title);
void main_loop(float *initial_frame, GLuint renderer, GLuint simulator);
void uninit();

#endif // COMMON_LIB_H

