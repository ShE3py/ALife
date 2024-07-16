#include <stdlib.h>
#include <stdio.h>

#include "common/lib.h"
#include "common/shader.h"
#include "common/config.h"

const char *const TITLE = "Physarum";

// Minimum OpenGL version: 3.0

EXPORT("_initialize")
int main(void) {
    /*
     * Seed intéressantes :
     * seed (widthxheight wrap bounce)
     * 1716745735 (1080x720 t f)
     */
    unsigned int seed = 1716756894; // time(NULL);
    srand(seed);
    printf("Seed is %u\n", seed);
    
    create_rcx();
    
    float *initial = malloc(WIDTH * HEIGHT * 3 * sizeof(float));
    if(!initial) {
        perror("malloc");
        exit(1);
    }
    
    for(size_t i = 0; i < (size_t) WIDTH * HEIGHT; ++i) {
        initial[3 * i    ] = rand() / (float) RAND_MAX > 0.95;
        initial[3 * i + 1] = rand() / (float) RAND_MAX; // (float) (int) (rand() / (float) RAND_MAX * 8) / 8;
        initial[3 * i + 2] = 0;
    }
    
    GLshader sPassthrough = createShader("src/common/passthrough.vsh", GL_VERTEX_SHADER  , "src/physarum/config.c");
    GLshader sRenderer    = createShader("src/physarum/renderer.fsh" , GL_FRAGMENT_SHADER, "src/physarum/config.c");
    GLshader sSimulator   = createShader("src/physarum/simulator.fsh", GL_FRAGMENT_SHADER, "src/physarum/config.c");
    
    GLprogram pRenderer = createProgram(sPassthrough, sRenderer);
    GLprogram pSimulator = createProgram(sPassthrough, sSimulator);
    
    setup(initial, pRenderer, pSimulator);
    main_loop();
    return 0;
}

