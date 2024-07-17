#include <stdlib.h>
#include <stdio.h>
#include <math.h>

#include "common/main.h"
#include "common/shader.h"
#include "common/config.h"

const char *const TITLE = "Gray-Scott";

// Minimum OpenGL version: 3.0

// CONFIG UNIFORMS //
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

// INITIAL FRAMES //
static float *frame = NULL;

EXPORT("set_frame")
void set_frame(int mode) {
    switch(mode) {
        // random
        case 0:
        default:
            for(size_t i = 0; i < (size_t) WIDTH * HEIGHT; ++i) {
                frame[3 * i    ] = 1;
                frame[3 * i + 1] = rand() / (float) RAND_MAX > 0.99;
                frame[3 * i + 2] = 0;
            }
            break;
        
        // line
        case 1:
            for(size_t i = 0; i < (size_t) WIDTH * HEIGHT; ++i) {
                size_t x = i % WIDTH;
                size_t y = i / WIDTH;
                
                frame[3 * i    ] = 1;
                frame[3 * i + 1] = (y == (size_t) HEIGHT / 2) && (x >= (size_t) WIDTH / 6) && (x <= (5 * (size_t) WIDTH) / 6);
                frame[3 * i + 2] = 0;
            }
            break;
        
        // circle
        case 2:
            for(size_t i = 0; i < (size_t) WIDTH * HEIGHT; ++i) {
                size_t x = i % WIDTH;
                size_t y = i / WIDTH;
                
                int dx = (WIDTH / 2) - x;
                int dy = (HEIGHT / 2) - y;
                int d2 = (dx * dx) + (dy * dy);
                
                const int r = WIDTH / 3;
                const int r2 = r * r;

                frame[3 * i    ] = 1;
                frame[3 * i + 1] = abs(d2 - r2) <= r;
                frame[3 * i + 2] = 0;
            }
            break;
        
        // sinus
        case 3:
            for(size_t i = 0; i < (size_t) WIDTH * HEIGHT; ++i) {
                size_t x = i % WIDTH;
                size_t y = i / WIDTH;
                
                float xf = 10 * (float) x / WIDTH;
                float yf = 2 * ((float) y / HEIGHT) - 1;
                
                float cosx = 0.67 * cosf(xf);

                frame[3 * i    ] = 1;
                frame[3 * i + 1] = (fabsf(cosx - yf) <= 0.01) && (x >= (size_t) WIDTH / 6) && (x <= (5 * (size_t) WIDTH) / 6);
                frame[3 * i + 2] = 0;
            }
            break;
    }
}

EXPORT("_initialize")
int main(void) {
    create_rcx();
    
    GLshader sPassthrough = createShader("src/common/passthrough.vsh"  , GL_VERTEX_SHADER  , "src/gray-scott/config.c");
    GLshader sRenderer    = createShader("src/gray-scott/renderer.fsh" , GL_FRAGMENT_SHADER, "src/gray-scott/config.c");
    GLshader sSimulator   = createShader("src/gray-scott/simulator.fsh", GL_FRAGMENT_SHADER, "src/gray-scott/config.c");
    
    GLprogram pRenderer = createProgram(sPassthrough, sRenderer);
    GLprogram pSimulator = createProgram(sPassthrough, sSimulator);
    
    frame = malloc(WIDTH * HEIGHT * 3 * sizeof(float));
    if(!frame) {
        perror("malloc");
        exit(1);
    }
    
    set_frame(0);
    setup(frame, pRenderer, pSimulator);
    
    uf  = glGetUniformLocation(pSimulator, "f");
    uk  = glGetUniformLocation(pSimulator, "k");
    uru = glGetUniformLocation(pSimulator, "ru");
    urv = glGetUniformLocation(pSimulator, "rv");
    udt = glGetUniformLocation(pSimulator, "dt");
    
    set_fk(0.046, 0.059);
    set_ru(1.0);
    set_rv(0.5);
    set_dt(1.0);
    
    main_loop();
    return 0;
}

