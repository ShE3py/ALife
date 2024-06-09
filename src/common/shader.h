#ifndef COMMON_SHADER_H
#define COMMON_SHADER_H

#include <glad/gl.h>

GLuint createShader(const char *filename, GLenum shaderType, const char *configFilename);
GLuint createProgram(GLuint vertexShader, GLuint fragmentShader);

#endif // COMMON_SHADER_H

