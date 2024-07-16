#include "lib.h"

#include <stdio.h>
#include <stdlib.h>

#include "gl.h"

#ifndef __wasm__
#   include "window.h"
#   include <GLFW/glfw3.h>
#endif // !__wasm__

#include "snap.h"

static GLuint renderer, simulator, frameBuf;
static int width, height;

void create_rcx(void) {
    extern int WIDTH, HEIGHT;
    width = WIDTH;
    height = HEIGHT;
    
    #ifndef __wasm__
        create_window(width, height);
    #endif // !__wasm__
}

void setup(float *initial_frame, GLprogram r, GLprogram s) {
    renderer = r;
    simulator = s;
    
    GLuint frameTex;
    glGenTextures(1, &frameTex);
    glBindTexture(GL_TEXTURE_2D, frameTex);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_NEAREST);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);
    glTexImage2D(GL_TEXTURE_2D, 0, GL_RGB, width, height, 0, GL_RGB, GL_FLOAT, &initial_frame[0]);
    
    GLuint worldTex;
    glGenTextures(1, &worldTex);
    glBindTexture(GL_TEXTURE_2D, worldTex);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_NEAREST);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);
    glTexImage2D(GL_TEXTURE_2D, 0, GL_RGB, width, height, 0, GL_RGB, GL_FLOAT, &initial_frame[0]);
    free(initial_frame);
    
    glGenFramebuffers(1, &frameBuf);
    glBindFramebuffer(GL_FRAMEBUFFER, frameBuf);
    glFramebufferTexture2D(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0, GL_TEXTURE_2D, frameTex, 0);
    const GLenum buf = GL_COLOR_ATTACHMENT0;
    glDrawBuffers(1, &buf);
    
    const float quadVertices[8] = {
        -1, -1,
        -1,  1,
         1, -1,
         1,  1
    };
    
    GLuint quad;
    glGenVertexArrays(1, &quad);
    glBindVertexArray(quad);
    
    GLuint position;
    glGenBuffers(1, &position);
    glBindBuffer(GL_ARRAY_BUFFER, position);
    glBufferData(GL_ARRAY_BUFFER, sizeof(quadVertices), &quadVertices[0], GL_STATIC_DRAW);
    glVertexAttribPointer(0, 2, GL_FLOAT, GL_FALSE, 0, NULL);
    glEnableVertexAttribArray(0);
    
    glClearColor(0, 0, 0, 1);
}

void next_frame(void) {
    glClear(GL_COLOR_BUFFER_BIT);
    
    glBindFramebuffer(GL_FRAMEBUFFER, frameBuf);
    glUseProgram(simulator);
    glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
    
    glCopyTexSubImage2D(GL_TEXTURE_2D, 0, 0, 0, 0, 0, width, height);
    
    glBindFramebuffer(GL_FRAMEBUFFER, 0);
    glUseProgram(renderer);
    glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
    
    write_frame();
}

#ifndef __wasm__
void main_loop(void) {
    while(!glfwWindowShouldClose(window)) {
        next_frame();
        
        glfwSwapBuffers(window);
        glfwPollEvents();
    }
    
    glfwTerminate();
}
#else
void main_loop(void) {}
#endif // __wasm__

