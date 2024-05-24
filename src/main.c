#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#include <glad/gl.h>
#include <GLFW/glfw3.h>

#include "codec.h"

#define STATIC static
#include "config.h"

// Minimum OpenGL version: 3.0

char* read_to_string(const char *filename, long *outLen) {
    FILE *f = fopen(filename, "rb");
    if(!f) {
        perror(filename);
        exit(-1);
    }
    fseek(f, 0, SEEK_END);
    long len = ftell(f);
    char *str = malloc(len + 1);
    if(!str) {
        perror("malloc");
        exit(1);
    }
    fseek(f, 0, SEEK_SET);
    fread(str, 1, len, f);
    fclose(f);
    
    if(outLen) {
        *outLen = len;
    }
    str[len] = '\0';
    return str;
}

size_t extract_version(const char *shader) {
    if(strncmp("#version", shader, 8) == 0) {
        size_t i = 8;
        while(shader[i] != '\0' && shader[i] != '\n') {
            ++i;
        }
        if(shader[i] == '\n') {
            ++i;
        }
        
        return i;
    }
    
    return 0;
}

GLuint createProgram(const char *vshFilename, const char *fshFilename) {
    long configLen;
    char *config = read_to_string("src/config.c", &configLen);
    
    long len;
    char *src = read_to_string(vshFilename, &len);
    
    size_t i = extract_version(src);
    if(i == 0) {
        fprintf(stderr, "missing #version");
        exit(1);
    }
    char *version = malloc(i);
    if(!version) {
        perror("malloc");
        exit(1);
    }
    memcpy(version, src, i);
    
    const char *line = "#line 1\n";
    const size_t lineLen = 8;
    
    const GLchar* sources[4] = { version, config, line, src + i };
    GLint lengths[4] = { i, configLen, lineLen, len };
    
    GLuint vsh = glCreateShader(GL_VERTEX_SHADER);
    glShaderSource(vsh, 4, sources, lengths);
    glCompileShader(vsh);
    free(src);
    free(version);
    
    src = read_to_string(fshFilename, &len);
    i = extract_version(src);
    if(i == 0) {
        fprintf(stderr, "missing #version");
        exit(1);
    }
    version = malloc(i);
    if(!version) {
        perror("malloc");
        exit(1);
    }
    memcpy(version, src, i);
    
    sources[0] = version;
    lengths[0] = i;
    sources[3] = src + i;
    lengths[3] = len;

    GLuint fsh = glCreateShader(GL_FRAGMENT_SHADER);
    glShaderSource(fsh, 4, sources, lengths);
    glCompileShader(fsh);
    free(src);
    free(version);
    free(config);
    
    GLint vStatus;
    glGetShaderiv(vsh, GL_COMPILE_STATUS, &vStatus);
    if(vStatus == GL_FALSE) {
        GLint logLen;
        glGetShaderiv(vsh, GL_INFO_LOG_LENGTH, &logLen);
        GLchar *log = malloc(logLen);
        glGetShaderInfoLog(vsh, logLen, NULL, log);
        fprintf(stderr, "could not compile `%s`: %s\n", vshFilename, log);
        free(log);
    }
    
    GLint fStatus;
    glGetShaderiv(fsh, GL_COMPILE_STATUS, &fStatus);
    if(fStatus == GL_FALSE) {
        GLint logLen;
        glGetShaderiv(fsh, GL_INFO_LOG_LENGTH, &logLen);
        GLchar *log = malloc(logLen);
        glGetShaderInfoLog(fsh, logLen, NULL, log);
        fprintf(stderr, "could not compile `%s`: %s\n", fshFilename, log);
        free(log);
        exit(1);
    }
    else if(vStatus == GL_FALSE) {
        exit(1);
    }

    GLuint program = glCreateProgram();
    glAttachShader(program, vsh);
    glAttachShader(program, fsh);
    glLinkProgram(program);
    
    GLint lStatus;
    glGetProgramiv(program, GL_LINK_STATUS, &lStatus);
    if(lStatus == GL_FALSE) {
        GLint logLen;
        glGetProgramiv(program, GL_INFO_LOG_LENGTH, &logLen);
        GLchar *log = malloc(logLen);
        glGetProgramInfoLog(program, logLen, NULL, log);
        fprintf(stderr, "could not link `%s` and `%s`: %s\n", vshFilename, fshFilename, log);
        free(log);
        exit(1);
    }

    glDetachShader(program, vsh);
    glDeleteShader(vsh);

    glDetachShader(program, fsh);
    glDeleteShader(fsh);

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
    
    //initial[3 * (HEIGHT / 2 * WIDTH + WIDTH / 2)] = 1;
    
    GLuint frameTex;
    glGenTextures(1, &frameTex);
    glBindTexture(GL_TEXTURE_2D, frameTex);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_NEAREST);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);
    glTexImage2D(GL_TEXTURE_2D, 0, GL_RGB, WIDTH, HEIGHT, 0, GL_RGB, GL_FLOAT, &initial[0]);
    
    GLuint worldTex;
    glGenTextures(1, &worldTex);
    glBindTexture(GL_TEXTURE_2D, worldTex);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_NEAREST);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);
    glTexImage2D(GL_TEXTURE_2D, 0, GL_RGB, WIDTH, HEIGHT, 0, GL_RGB, GL_FLOAT, &initial[0]);
    free(initial);
    
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
        //write_frame();
        
        glBindFramebuffer(GL_FRAMEBUFFER, 0);
        glUseProgram(renderer);
        glDrawArrays(GL_QUADS, 0, 4);
        
        glfwSwapBuffers(window);
        glfwPollEvents();
    }

    glfwTerminate();
    return 0;
}

