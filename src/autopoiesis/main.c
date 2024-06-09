#include <stdlib.h>
#include <stdio.h>
#include <time.h>
#include <math.h>

#include "common/lib.h"
#include "common/shader.h"
#include "config.h"

// Minimum OpenGL version: 3.0

int main() {
    set_size(WIDTH, HEIGHT);
    init("Autopoïèse");
    
    float *initial = malloc(WIDTH * HEIGHT * 3 * sizeof(float));
    if(!initial) {
        perror("malloc");
        exit(1);
    }
    
    for(size_t i = 0; i < (size_t) WIDTH * HEIGHT; ++i) {
        initial[3 * i    ] = X;
        initial[3 * i + 1] = 0; // rand() / (float) RAND_MAX; // (float) (int) (rand() / (float) RAND_MAX * 8) / 8;
        initial[3 * i + 2] = 0;
    }
    
    int cx = WIDTH / 2, cy = HEIGHT / 2;
    
    for(float alpha = 0; alpha <= 1; alpha += 0.0001) {
        float beta = alpha * (2 * M_PI);
        int x = CELL_RADIUS * cos(beta) + cx;
        int y = CELL_RADIUS * sin(beta) + cy;
        
        int i = x * HEIGHT + y;
        initial[3 * i] = C;
        initial[3 * i + 1] = alpha;
    }
    
    GLuint sPassthrough = createShader("src/common/passthrough.vsh", GL_VERTEX_SHADER  , "src/autopoiesis/config.c");
    GLuint sRenderer    = createShader("src/autopoiesis/renderer.fsh" , GL_FRAGMENT_SHADER, "src/autopoiesis/config.c");
    GLuint sSimulator   = createShader("src/autopoiesis/simulator.fsh", GL_FRAGMENT_SHADER, "src/autopoiesis/config.c");
    
    GLuint pRenderer = createProgram(sPassthrough, sRenderer);
    GLuint pSimulator = createProgram(sPassthrough, sSimulator);
    
    main_loop(initial, pRenderer, pSimulator);
    uninit();
    
    return 0;
}

