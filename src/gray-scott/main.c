#include <stdlib.h>
#include <stdio.h>
#include <math.h>

#include "common/main.h"
#include "common/shader.h"
#include "common/config.h"

#include "xmorphia.h"

const char *const TITLE = "Gray-Scott";

static float max(float, float, float);

// Minimum OpenGL version: 3.0

// GLOBALS //
static GLprogram pRenderer = 0, pSimulator = 0;

// CONFIG UNIFORMS //
static GLint uf = INVALID_UNIFORM, uk = INVALID_UNIFORM;
static float f = 0, k = 0;

EXPORT("set_fk")
void set_fk(float vf, float vk) {
    glUniform1f(uf, vf);
    glUniform1f(uk, vk);
    f = vf;
    k = vk;
}

EXPORT("set_f")
void set_f(float vf) {
    glUniform1f(uf, vf);
    f = vf;
}

EXPORT("set_k")
void set_k(float vk) {
    glUniform1f(uk, vk);
    k = vk;
}

static GLint uru = INVALID_UNIFORM, urv = INVALID_UNIFORM;

EXPORT("set_ru")
void set_ru(float vru) {
    glUniform1f(uru, vru);
}

EXPORT("set_rv")
void set_rv(float vrv) {
    glUniform1f(urv, vrv);
}

static GLint uDt = INVALID_UNIFORM;

EXPORT("set_Dt")
void set_Dt(float vDt) {
    glUniform1f(uDt, vDt);
}

static GLint urgb = INVALID_UNIFORM;

EXPORT("set_color")
void set_rgb(float vr, float vg, float vb) {
    // Brighten the color
    float vm = max(vr, vg, vb);
    float f = 1 / vm;
    
    glUseProgram(pRenderer);
    glUniform3f(urgb, vr * f, vg * f, vb * f);
    glUseProgram(pSimulator);
}

// INITIAL FRAMES //
static float *frame = NULL;

EXPORT("set_frame")
void set_frame(int mode) {
    // TODO: grid
    switch(mode) {
        // Random
        case 0:
        default:
            for(size_t i = 0; i < (size_t) WIDTH * HEIGHT; ++i) {
                frame[3 * i    ] = 1;
                frame[3 * i + 1] = rand() / (float) RAND_MAX > 0.995;
                frame[3 * i + 2] = 0;
            }
            break;
        
        // Gradient
        case 7:
            for(size_t i = 0; i < (size_t) WIDTH * HEIGHT; ++i) {
                size_t x = i % WIDTH;
                size_t y = i / WIDTH;
                
                noise(f, k, &frame[3 * i], x, y);
                frame[3 * i + 2] = 0;
            }
            break;
        
        // Square (Filled)
        case 1:
            for(size_t i = 0; i < (size_t) WIDTH * HEIGHT; ++i) {
                size_t x = i % WIDTH;
                size_t y = i / WIDTH;
                
                frame[3 * i    ] = 1;
                frame[3 * i + 1] = (x >= (size_t) WIDTH / 6) && (x <= (5 * (size_t) WIDTH) / 6) && (y >= (size_t) HEIGHT / 6) && (y <= (5 * (size_t) HEIGHT) / 6);
                frame[3 * i + 2] = 0;
            }
            break;
        
        // Square (Outline)
        case 2:
            for(size_t i = 0; i < (size_t) WIDTH * HEIGHT; ++i) {
                size_t x = i % WIDTH;
                size_t y = i / WIDTH;
                
                int horizontal = (x >= (size_t) WIDTH  / 6 - 5) && (x <= (5 * (size_t) WIDTH ) / 6 + 5) && (abs(abs((HEIGHT / 2) - (int) y) - (HEIGHT / 3)) <= 5);
                int vertical   = (y >= (size_t) HEIGHT / 6 - 5) && (y <= (5 * (size_t) HEIGHT) / 6 + 5) && (abs(abs((WIDTH  / 2) - (int) x) - (WIDTH  / 3)) <= 5);
                
                frame[3 * i    ] = 1;
                frame[3 * i + 1] = horizontal || vertical;
                frame[3 * i + 2] = 0;
            }
            break;
        
        // Circle (Filled)
        case 3:
            for(size_t i = 0; i < (size_t) WIDTH * HEIGHT; ++i) {
                size_t x = i % WIDTH;
                size_t y = i / WIDTH;
                
                int dx = (WIDTH / 2) - x;
                int dy = (HEIGHT / 2) - y;
                int d2 = (dx * dx) + (dy * dy);
                
                const int r = WIDTH / 3;
                const int r2 = r * r;

                frame[3 * i    ] = 1;
                frame[3 * i + 1] = d2 <= r2;
                frame[3 * i + 2] = 0;
            }
            break;
        
        // Circle (Outline)
        case 4:
            for(size_t i = 0; i < (size_t) WIDTH * HEIGHT; ++i) {
                size_t x = i % WIDTH;
                size_t y = i / WIDTH;
                
                int dx = (WIDTH / 2) - x;
                int dy = (HEIGHT / 2) - y;
                int d2 = (dx * dx) + (dy * dy);
                
                const int r = WIDTH / 3;
                const int r2 = r * r;

                frame[3 * i    ] = 1;
                frame[3 * i + 1] = abs(d2 - r2) <= r * 5;
                frame[3 * i + 2] = 0;
            }
            break;
        
        // Sinusoid
        case 5:
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
        
        // Line
        case 6:
            for(size_t i = 0; i < (size_t) WIDTH * HEIGHT; ++i) {
                size_t x = i % WIDTH;
                size_t y = i / WIDTH;
                
                frame[3 * i    ] = 1;
                frame[3 * i + 1] = (y == (size_t) HEIGHT / 2) && (x >= (size_t) WIDTH / 6) && (x <= (5 * (size_t) WIDTH) / 6);
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
    
    pRenderer = createProgram(sPassthrough, sRenderer);
    pSimulator = createProgram(sPassthrough, sSimulator);
    
    frame = malloc(WIDTH * HEIGHT * 3 * sizeof(float));
    if(!frame) {
        perror("malloc");
        exit(1);
    }
    
    set_frame(0);
    setup(frame, pRenderer, pSimulator);
    
    uf   = glGetUniformLocation(pSimulator, "f");
    uk   = glGetUniformLocation(pSimulator, "k");
    uru  = glGetUniformLocation(pSimulator, "ru");
    urv  = glGetUniformLocation(pSimulator, "rv");
    uDt  = glGetUniformLocation(pSimulator, "Dt");
    urgb = glGetUniformLocation(pRenderer , "rgb");
    
    set_fk(0.046, 0.059);
    set_ru(1.0);
    set_rv(0.5);
    set_Dt(1.0);
    set_rgb(0.235, 1.000, 0.412);
    
    main_loop();
    return 0;
}

static float max(float x, float y, float z) {
    if(x > y) {
        return (z > x) ? z : x;
    }
    else /* y >= x */ {
        return (z > y) ? z : y;
    }
}

