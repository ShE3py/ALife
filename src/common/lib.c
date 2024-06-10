#include "lib.h"

#include "common/wasm.h"

#ifndef __wasm__
#  include <stdio.h>
#  include <stdlib.h>

#  include <GLFW/glfw3.h>
#endif // __wasm__

#include "common/snap.h"

static int width = 0, height = 0;

EXPORT("set_size")
void set_size(int w, int h) {
    width = w;
    height = h;
}

#ifndef __wasm__
static APIENTRY void gl_callback(GLenum, GLenum, GLuint, GLenum, GLsizei, const GLchar*, const void*);
static void glfw_callback(int, const char*);

static GLFWwindow *window = NULL;

void init(const char *title) {
    glfwSetErrorCallback(glfw_callback);
    if(!glfwInit()) {
        exit(1);
    }
    
    glfwWindowHint(GLFW_OPENGL_DEBUG_CONTEXT, GLFW_TRUE);
    window = glfwCreateWindow(width, height, title, NULL, NULL);
    if(!window) {
        glfwTerminate();
        exit(1);
    }
    
    glfwMakeContextCurrent(window);
    if(gladLoadGL(glfwGetProcAddress) == 0) {
        exit(1);
    }
    
    glDebugMessageCallback(gl_callback, NULL);
    glfwSwapInterval(1);
}

void next_frame();

void main_loop() {
     while(!glfwWindowShouldClose(window)) {
        next_frame();
        
        glfwSwapBuffers(window);
        glfwPollEvents();
    }
}
#endif // __wasm__

static GLuint renderer, simulator, frameBuf;

EXPORT("setup")
void setup(float *initial_frame, GLuint r, GLuint s) {
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
        -1,  1,
        -1, -1,
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
}

EXPORT("next_frame")
void next_frame() {
    glClear(GL_COLOR_BUFFER_BIT);
    
    glBindFramebuffer(GL_FRAMEBUFFER, frameBuf);
    glUseProgram(simulator);
    glDrawArrays(GL_QUADS, 0, 4);
    
    glCopyTexSubImage2D(GL_TEXTURE_2D, 0, 0, 0, 0, 0, width, height);
    
    glBindFramebuffer(GL_FRAMEBUFFER, 0);
    glUseProgram(renderer);
    glDrawArrays(GL_QUADS, 0, 4);
    
    write_frame();
}

#ifndef __wasm__
void uninit() {
    glfwTerminate();
}

static void glfw_callback(int error_code, const char *description) {
    fprintf(stderr, "glfw: %d: %s\n", error_code, description);
}

static APIENTRY void gl_callback(GLenum source, GLenum type, GLuint id, GLenum severity, GLsizei length, const GLchar *message, const void *userParam) {
    const char *src;
    switch(source) {
        case GL_DEBUG_SOURCE_API:
            src = "GL_DEBUG_SOURCE_API";
            break;
        case GL_DEBUG_SOURCE_WINDOW_SYSTEM:
            src = "GL_DEBUG_SOURCE_WINDOW_SYSTEM";
            break;
        case GL_DEBUG_SOURCE_SHADER_COMPILER:
            src = "GL_DEBUG_SOURCE_SHADER_COMPILER";
            break;
        case GL_DEBUG_SOURCE_THIRD_PARTY:
            src = "GL_DEBUG_SOURCE_THIRD_PARTY";
            break;
        case GL_DEBUG_SOURCE_APPLICATION:
            src = "GL_DEBUG_SOURCE_APPLICATION";
            break;
        default:
            src = "GL_DEBUG_SOURCE_OTHER";
            break;
    }
    
    const char *ty;
    switch(type) {
        case GL_DEBUG_TYPE_ERROR:
            ty = "GL_DEBUG_TYPE_ERROR";
            break;
        case GL_DEBUG_TYPE_DEPRECATED_BEHAVIOR:
            ty = "GL_DEBUG_TYPE_DEPRECATED_BEHAVIOR";
            break;
        case GL_DEBUG_TYPE_UNDEFINED_BEHAVIOR:
            ty = "GL_DEBUG_TYPE_UNDEFINED_BEHAVIOR";
            break;
        case GL_DEBUG_TYPE_PORTABILITY:
            ty = "GL_DEBUG_TYPE_PORTABILITY";
            break;
        case GL_DEBUG_TYPE_PERFORMANCE:
            ty = "GL_DEBUG_TYPE_PERFORMANCE";
            break;
        case GL_DEBUG_TYPE_MARKER:
            ty = "GL_DEBUG_TYPE_MARKER";
            break;
        case GL_DEBUG_TYPE_PUSH_GROUP:
            ty = "GL_DEBUG_TYPE_PUSH_GROUP";
            break;
        case GL_DEBUG_TYPE_POP_GROUP:
            ty = "GL_DEBUG_TYPE_POP_GROUP";
            break;
        default:
            ty = "GL_DEBUG_TYPE_OTHER";
            break;
    }
    
    const char *sev;
    switch(severity) {
        case GL_DEBUG_SEVERITY_HIGH:
            sev = "GL_DEBUG_SEVERITY_HIGH";
            break;
        case GL_DEBUG_SEVERITY_MEDIUM:
            sev = "GL_DEBUG_SEVERITY_MEDIUM";
            break;
        case GL_DEBUG_SEVERITY_LOW:
            sev = "GL_DEBUG_SEVERITY_LOW";
            break;
        case GL_DEBUG_SEVERITY_NOTIFICATION:
            sev = "GL_DEBUG_SEVERITY_NOTIFICATION";
            break;
        default:
            sev = "<unknown severity>";
            break;
    }
    
    printf("%s %s in %s: %s\n", sev, ty, src, message);
}
#endif // __wasm__

