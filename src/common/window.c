#include "window.h"

#include <stdlib.h>
#include <stdio.h>

#include <glad/gl.h>
#include <GLFW/glfw3.h>

static APIENTRY void gl_callback(GLenum, GLenum, GLuint, GLenum, GLsizei, const GLchar*, const void*);
static void glfw_callback(int, const char*);

GLFWwindow *window = NULL;

void create_window(int width, int height) {
    extern const char *const TITLE;
    
    glfwSetErrorCallback(glfw_callback);
    if(!glfwInit()) {
        exit(1);
    }
    
    glfwWindowHint(GLFW_OPENGL_DEBUG_CONTEXT, GLFW_TRUE);
    window = glfwCreateWindow(width, height, TITLE, NULL, NULL);
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

static void glfw_callback(int error_code, const char *description) {
    fprintf(stderr, "glfw: %d: %s\n", error_code, description);
}

