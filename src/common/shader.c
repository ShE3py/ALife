#include "shader.h"

#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <inttypes.h>

#include <glad/gl.h>

static char* read_to_string(const char*, long*);
static size_t extract_version(const char*);

GLuint createShader(const char *filename, GLenum shaderType, const char *configFilename) {
    long configLen;
    char *config = read_to_string(configFilename, &configLen);
    
    long len;
    char *src = read_to_string(filename, &len);
    
    size_t i = extract_version(src);
    if(i == 0) {
        fprintf(stderr, "missing #version in `%s`\n", filename);
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
    
    GLuint shader = glCreateShader(shaderType);
    glShaderSource(shader, 4, sources, lengths);
    glCompileShader(shader);
    
    free(config);
    free(src);
    
    GLint status;
    glGetShaderiv(shader, GL_COMPILE_STATUS, &status);
    if(status == GL_FALSE) {
        GLint logLen;
        glGetShaderiv(shader, GL_INFO_LOG_LENGTH, &logLen);
        GLchar *log = malloc(logLen);
        if(!log) {
            perror("malloc");
            exit(1);
        }
        glGetShaderInfoLog(shader, logLen, NULL, log);
        fprintf(stderr, "could not compile `%s`: %s\n", filename, log);
        free(log);
        exit(1);
    }
    
    return shader;
}

GLuint createProgram(GLuint vertexShader, GLuint fragmentShader) {
    GLuint program = glCreateProgram();
    glAttachShader(program, vertexShader);
    glAttachShader(program, fragmentShader);
    glLinkProgram(program);
    
    GLint status;
    glGetProgramiv(program, GL_LINK_STATUS, &status);
    if(status == GL_FALSE) {
        GLint logLen;
        glGetProgramiv(program, GL_INFO_LOG_LENGTH, &logLen);
        GLchar *log = malloc(logLen);
        if(!log) {
            perror("malloc");
            exit(1);
        }
        glGetProgramInfoLog(program, logLen, NULL, log);
        fprintf(stderr, "could not link %" PRIu32 " and %" PRIu32 ": %s\n", vertexShader, fragmentShader, log);
        free(log);
        exit(1);
    }
    
    return program;
}

/**
 * Renvoie le contenu du fichier `filename` sous la forme d'une chaîne de caractères.
 * Si `outLen != NULL`, le modifie pour contenir la taille de la chaîne ('\0' exclu).
 */
static char* read_to_string(const char *filename, long *outLen) {
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

/**
 * Renvoie l'indice de fin de la directive `#version`, retour à la ligne inclu.
 */
static size_t extract_version(const char *shader) {
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

