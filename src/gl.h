#ifndef __wasm__
#   include <glad/gl.h>
#else
#   ifndef GL_H
#   define GL_H

/*
** Copyright 2013-2020 The Khronos Group Inc.
** SPDX-License-Identifier: MIT
*/

typedef unsigned int GLenum;
typedef int GLint;
typedef unsigned int GLuint;
typedef int GLsizei;
typedef char GLchar;
typedef signed int GLsizeiptr;
typedef unsigned int GLbitfield;
typedef unsigned char GLboolean;
typedef float GLfloat;

#define APIENTRY
#define GL_FALSE                          0
#define GL_LINK_STATUS                    0x8B82
#define GL_INFO_LOG_LENGTH                0x8B84
#define GL_TEXTURE_2D                     0x0DE1
#define GL_TEXTURE_MAG_FILTER             0x2800
#define GL_TEXTURE_MIN_FILTER             0x2801
#define GL_NEAREST                        0x2600
#define GL_RGB                            0x1907
#define GL_RGBA                           0x1908
#define GL_FLOAT                          0x1406
#define GL_FRAMEBUFFER                    0x8D40
#define GL_COLOR_ATTACHMENT0              0x8CE0
#define GL_ARRAY_BUFFER                   0x8892
#define GL_STATIC_DRAW                    0x88E4
#define GL_COLOR_BUFFER_BIT               0x00004000
#define GL_FRAGMENT_SHADER                0x8B30
#define GL_VERTEX_SHADER                  0x8B31
#define GL_PIXEL_UNPACK_BUFFER            0x88EC
#define GL_UNPACK_ALIGNMENT               0x0CF5
#define GL_TEXTURE0                       0x84C0
#define GL_TRIANGLE_STRIP                 0x0005

#define IMPORT(n) __attribute__((import_name(n), import_module("common")))

IMPORT("glCreateProgram") GLuint glCreateProgram(void);
IMPORT("glAttachShader") void glAttachShader(GLuint, GLuint);
IMPORT("glLinkProgram") void glLinkProgram(GLuint);
IMPORT("glGetProgramiv") void glGetProgramiv(GLuint, GLenum, GLint*);
IMPORT("glGetProgramInfoLog") void glGetProgramInfoLog(GLuint, GLsizei, GLsizei*, GLchar*);
IMPORT("glGenTextures") void glGenTextures(GLsizei, GLuint*);
IMPORT("glActiveTexture") void glActiveTexture(GLenum);
IMPORT("glBindTexture") void glBindTexture(GLenum, GLuint);
IMPORT("glTexParameteri") void glTexParameteri(GLenum, GLenum, GLint);
IMPORT("glTexImage2D") void glTexImage2D(GLenum, GLint, GLint, GLsizei, GLsizei, GLint, GLenum, GLenum, const void*);
IMPORT("glGenFramebuffers") void glGenFramebuffers(GLsizei, GLuint*);
IMPORT("glBindFramebuffer") void glBindFramebuffer(GLenum, GLuint);
IMPORT("glFramebufferTexture2D") void glFramebufferTexture2D(GLenum, GLenum, GLenum, GLuint, GLint);
IMPORT("glDrawBuffers") void glDrawBuffers(GLsizei, const GLenum*);
IMPORT("glGenVertexArrays") void glGenVertexArrays(GLsizei, GLuint*);
IMPORT("glBindVertexArray") void glBindVertexArray(GLuint);
IMPORT("glGenBuffers") void glGenBuffers(GLsizei, GLuint*);
IMPORT("glBindBuffer") void glBindBuffer(GLenum, GLuint);
IMPORT("glBufferData") void glBufferData(GLenum, GLsizeiptr, const void*, GLenum);
IMPORT("glVertexAttribPointer") void glVertexAttribPointer(GLuint, GLint, GLenum, GLboolean, GLsizei, const void*);
IMPORT("glEnableVertexAttribArray") void glEnableVertexAttribArray(GLuint);
IMPORT("glClearColor") void glClearColor(GLfloat, GLfloat, GLfloat, GLfloat);
IMPORT("glClear") void glClear(GLbitfield);
IMPORT("glUseProgram") void glUseProgram(GLuint);
IMPORT("glDrawArrays") void glDrawArrays(GLenum, GLint, GLsizei);
IMPORT("glCopyTexSubImage2D") void glCopyTexSubImage2D(GLenum, GLint, GLint, GLint, GLint, GLint, GLsizei, GLsizei);
IMPORT("glPixelStorei") void glPixelStorei(GLenum, GLint);
IMPORT("glGetUniformLocation") GLint glGetUniformLocation(GLuint, const GLchar*);
IMPORT("glUniform1f") void glUniform1f(GLint, GLfloat);
IMPORT("glUniform3f") void glUniform3f(GLint, GLfloat, GLfloat, GLfloat);

#   endif // GL_H
#endif // !__wasm__

typedef GLuint GLprogram;
typedef GLuint GLshader;

#define INVALID_UNIFORM 2147483647

