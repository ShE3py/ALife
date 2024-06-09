#ifndef COMMON_SHADER_H
#define COMMON_SHADER_H

#include <stdint.h>

typedef uint32_t GLuint;
typedef uint32_t GLenum;

#define GL_FRAGMENT_SHADER 0x8B30
#define GL_VERTEX_SHADER 0x8B31

GLuint createShader(const char *filename, GLenum shaderType, const char *configFilename);
GLuint createProgram(GLuint vertexShader, GLuint fragmentShader);

#endif // COMMON_SHADER_H

