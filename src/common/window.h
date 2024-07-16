#ifdef __wasm__
#   error
#endif // __wasm__

#ifndef COMMON_WINDOW_H
#define COMMON_WINDOW_H

typedef struct GLFWwindow GLFWwindow;

extern GLFWwindow *window;

void create_window(int w, int h);

#endif // COMMON_WINDOW_H

