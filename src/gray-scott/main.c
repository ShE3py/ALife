#include <stdlib.h>
#include <stdio.h>

#include "common/main.h"
#include "common/shader.h"
#include "config.h"

const char *const TITLE = "Gray-Scott";

// Minimum OpenGL version: 3.0

static GLint f, k;

EXPORT("set_f")
void set_f(float val) {
    glUniform1f(f, val);
}

EXPORT("set_k")
void set_k(float val) {
    glUniform1f(k, val);
}

EXPORT("_initialize")
int main(void) {
    create_rcx();
    
    float *initial = malloc(WIDTH * HEIGHT * 3 * sizeof(float));
    if(!initial) {
        perror("malloc");
        exit(1);
    }
    
    for(size_t i = 0; i < (size_t) WIDTH * HEIGHT; ++i) {
        initial[3 * i    ] = 1;
        initial[3 * i + 1] = rand() / (float) RAND_MAX > 0.99;
        initial[3 * i + 2] = 0;
    }
    
    GLshader sPassthrough = createShader("src/common/passthrough.vsh", GL_VERTEX_SHADER  , "src/gray-scott/config.c");
    GLshader sRenderer    = createShader("src/gray-scott/renderer.fsh" , GL_FRAGMENT_SHADER, "src/gray-scott/config.c");
    GLshader sSimulator   = createShader("src/gray-scott/simulator.fsh", GL_FRAGMENT_SHADER, "src/gray-scott/config.c");
    
    GLprogram pRenderer = createProgram(sPassthrough, sRenderer);
    GLprogram pSimulator = createProgram(sPassthrough, sSimulator);
    
    setup(initial, pRenderer, pSimulator);
    
    f = glGetUniformLocation(pSimulator, "f");
    k = glGetUniformLocation(pSimulator, "k");
    
    set_f(FEED_RATE_F);
    set_k(DECAY_RATE_K);
    
    main_loop();
    return 0;
}

