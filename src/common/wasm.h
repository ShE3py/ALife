#ifndef COMMON_WASM_H
#define COMMON_WASM_H

#ifndef __wasm__
#  include <stdlib.h>
#  include <stdio.h>
#  include <inttypes.h>
#  include <glad/gl.h>

#  define EXPORT(s)
#  define IMPORT(s)
#else

#define EXPORT(s) __attribute__((export_name(s)))
#define IMPORT(s) __attribute__((import_name(s), import_module("common")))

#define NULL 0

typedef unsigned long size_t;

typedef int FILE;
#define stdout ((FILE*) 0)
#define stderr ((FILE*) 1)

#define PRIu32 "u"
IMPORT("fprintf") int fprintf(FILE*, const char*, ...);
int printf(const char*, ...);

void perror(const char*);
IMPORT("exit") _Noreturn void exit(int);

IMPORT("srand") void srand(unsigned);
IMPORT("rand") int rand();
#define RAND_MAX 2147483647

void* malloc(size_t);
void free(void*);

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

__attribute__((import_name("glCreateProgram"))) GLuint glCreateProgram(void);
__attribute__((import_name("glAttachShader"))) void glAttachShader(GLuint, GLuint);
__attribute__((import_name("glLinkProgram"))) void glLinkProgram(GLuint);
__attribute__((import_name("glGetProgramiv"))) void glGetProgramiv(GLuint, GLenum, GLint*);
__attribute__((import_name("glGetProgramInfoLog"))) void glGetProgramInfoLog(GLuint, GLsizei, GLsizei*, GLchar*);
__attribute__((import_name("glGenTextures"))) void glGenTextures(GLsizei, GLuint*);
__attribute__((import_name("glActiveTexture"))) void glActiveTexture(GLenum);
__attribute__((import_name("glBindTexture"))) void glBindTexture(GLenum, GLuint);
__attribute__((import_name("glTexParameteri"))) void glTexParameteri(GLenum, GLenum, GLint);
__attribute__((import_name("glTexImage2D"))) void glTexImage2D(GLenum, GLint, GLint, GLsizei, GLsizei, GLint, GLenum, GLenum, const void*);
__attribute__((import_name("glGenFramebuffers"))) void glGenFramebuffers(GLsizei, GLuint*);
__attribute__((import_name("glBindFramebuffer"))) void glBindFramebuffer(GLenum, GLuint);
__attribute__((import_name("glFramebufferTexture2D"))) void glFramebufferTexture2D(GLenum, GLenum, GLenum, GLuint, GLint);
__attribute__((import_name("glDrawBuffers"))) void glDrawBuffers(GLsizei, const GLenum*);
__attribute__((import_name("glGenVertexArrays"))) void glGenVertexArrays(GLsizei, GLuint*);
__attribute__((import_name("glBindVertexArray"))) void glBindVertexArray(GLuint);
__attribute__((import_name("glGenBuffers"))) void glGenBuffers(GLsizei, GLuint*);
__attribute__((import_name("glBindBuffer"))) void glBindBuffer(GLenum, GLuint);
__attribute__((import_name("glBufferData"))) void glBufferData(GLenum, GLsizeiptr, const void*, GLenum);
__attribute__((import_name("glVertexAttribPointer"))) void glVertexAttribPointer(GLuint, GLint, GLenum, GLboolean, GLsizei, const void*);
__attribute__((import_name("glEnableVertexAttribArray"))) void glEnableVertexAttribArray(GLuint);
__attribute__((import_name("glClearColor"))) void glClearColor(GLfloat, GLfloat, GLfloat, GLfloat);
__attribute__((import_name("glClear"))) void glClear(GLbitfield);
__attribute__((import_name("glUseProgram"))) void glUseProgram(GLuint);
__attribute__((import_name("glDrawArrays"))) void glDrawArrays(GLenum, GLint, GLsizei);
__attribute__((import_name("glCopyTexSubImage2D"))) void glCopyTexSubImage2D(GLenum, GLint, GLint, GLint, GLint, GLint, GLsizei, GLsizei);
__attribute__((import_name("glPixelStorei"))) void glPixelStorei(GLenum, GLint);

#endif

#endif // COMMON_WASM_H

