#include <stdlib.h>
#include <stdio.h>

#include "common/main.h"
#include "common/shader.h"
#include "common/config.h"

const char *const TITLE = "Gray-Scott";

// Minimum OpenGL version: 3.0

static GLint uf, uk;

EXPORT("set_fk")
void set_fk(float vf, float vk) {
    glUniform1f(uf, vf);
    glUniform1f(uk, vk);
}

EXPORT("set_f")
void set_f(float vf) {
    glUniform1f(uf, vf);
}

EXPORT("set_k")
void set_k(float vk) {
    glUniform1f(uk, vk);
}

static GLint uru, urv;

EXPORT("set_ru")
void set_ru(float vru) {
    glUniform1f(uru, vru);
}

EXPORT("set_rv")
void set_rv(float vrv) {
    glUniform1f(urv, vrv);
}

static GLint udt;

EXPORT("set_dt")
void set_dt(float vdt) {
    glUniform1f(udt, vdt);
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
    
    uf  = glGetUniformLocation(pSimulator, "f");
    uk  = glGetUniformLocation(pSimulator, "k");
    uru = glGetUniformLocation(pSimulator, "ru");
    urv = glGetUniformLocation(pSimulator, "rv");
    udt = glGetUniformLocation(pSimulator, "dt");
    
    set_fk(0.050, 0.063);
    set_ru(1.0);
    set_rv(0.5);
    set_dt(1.0);
    
    main_loop();
    return 0;
}

