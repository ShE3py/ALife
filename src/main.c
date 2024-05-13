#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#include <glad/gl.h>
#include <GLFW/glfw3.h>

static const int WIDTH = 720;
static const int HEIGHT = 480;

// Minimum OpenGL version: 3.0

GLuint createProgram(const char *vshFilename, const char *fshFilename) {
    FILE *f = fopen(vshFilename, "rb");
    if(!f) {
        perror(vshFilename);
        exit(-1);
    }
    fseek(f, 0, SEEK_END);
    GLint len = ftell(f);
    GLchar *src = malloc(len);
    fseek(f, 0, SEEK_SET);
    fread(src, 1, len, f);
    fclose(f);
    
    GLuint vsh = glCreateShader(GL_VERTEX_SHADER);
    glShaderSource(vsh, 1, (const GLchar* const*) &src, &len);
    glCompileShader(vsh);
    
    f = fopen(fshFilename, "rb");
    if(!f) {
        perror(fshFilename);
        exit(-1);
    }
    fseek(f, 0, SEEK_END);
    len = ftell(f);
    src = realloc(src, len);
    fseek(f, 0, SEEK_SET);
    fread(src, 1, len, f);
    fclose(f);
    
    GLuint fsh = glCreateShader(GL_FRAGMENT_SHADER);
    glShaderSource(fsh, 1, (const GLchar* const*) &src, &len);
    glCompileShader(fsh);
    
    GLuint program = glCreateProgram();
    glAttachShader(program, vsh);
    glAttachShader(program, fsh);
    glLinkProgram(program);
    
    glDetachShader(program, vsh);
    glDeleteShader(vsh);
    
    glDetachShader(program, fsh);
    glDeleteShader(fsh);
    
    free(src);
    
    return program;
}

APIENTRY void debugCallback(GLenum source, GLenum type, GLuint id, GLenum severity, GLsizei length, const GLchar *message, const void *userParam) {
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

int main() {
    if(!glfwInit()) {
        return -1;
    }
    
    glfwWindowHint(GLFW_OPENGL_DEBUG_CONTEXT, GLFW_TRUE);
    GLFWwindow *window = glfwCreateWindow(WIDTH, HEIGHT, "Blob", NULL, NULL);
    if(!window) {
        glfwTerminate();
        return -1;
    }
    
    glfwMakeContextCurrent(window);
    if(gladLoadGL(glfwGetProcAddress) == 0) {
        return -1;
    }
    
    glDebugMessageCallback(debugCallback, NULL);
    
    float initial[WIDTH * HEIGHT * 3];
    for(size_t i = 0; i < WIDTH * HEIGHT; ++i) {
        initial[3 * i    ] = rand() / (float) RAND_MAX > 0.99;
        initial[3 * i + 1] = 0;
        initial[3 * i + 2] = 0;
    }
    
    GLuint frameTex;
    glGenTextures(1, &frameTex);
    glBindTexture(GL_TEXTURE_2D, frameTex);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_NEAREST);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);
    glTexImage2D(GL_TEXTURE_2D, 0, GL_RGB, WIDTH, HEIGHT, 0, GL_RGB, GL_FLOAT, &initial[0]);
    glActiveTexture(GL_TEXTURE0);
    
    GLuint worldTex;
    glGenTextures(1, &worldTex);
    glBindTexture(GL_TEXTURE_2D, worldTex);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_NEAREST);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);
    glTexImage2D(GL_TEXTURE_2D, 0, GL_RGB, WIDTH, HEIGHT, 0, GL_RGB, GL_FLOAT, &initial[0]);
    
    GLuint frameBuf;
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
    
    GLuint renderer = createProgram("src/passthrough.vsh", "src/renderer.fsh");
    GLuint simulator = createProgram("src/passthrough.vsh", "src/simulator.fsh");
    
    while(!glfwWindowShouldClose(window)) {
        glClear(GL_COLOR_BUFFER_BIT);
        
        glBindFramebuffer(GL_FRAMEBUFFER, frameBuf);
        glUseProgram(simulator);
        glDrawArrays(GL_QUADS, 0, 4);
        
        glCopyTexSubImage2D(GL_TEXTURE_2D, 0, 0, 0, 0, 0, WIDTH, HEIGHT);
        
        glBindFramebuffer(GL_FRAMEBUFFER, 0);
        glUseProgram(renderer);
        glDrawArrays(GL_QUADS, 0, 4);
        
        glfwSwapBuffers(window);
        glfwPollEvents();
    }

    glfwTerminate();
    return 0;
}

