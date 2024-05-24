#include "codec.h"

#include <stdio.h>
#include <stdlib.h>
#include <inttypes.h>

#include <glad/gl.h>

#include "config.h"

// https://stackoverflow.com/a/31685135
void FBO_2_PPM_file() {
    unsigned char *pixels = malloc(WIDTH * HEIGHT * 3);
    glReadBuffer(GL_COLOR_ATTACHMENT0);
    glReadPixels(0, 0, WIDTH, HEIGHT, GL_RGB, GL_UNSIGNED_BYTE, pixels);
    
    static uint64_t frame = 0;
    
    // "frame/%d.ppm" => 6 + log10(2^64 - 1) + 4 + 1
    char fileName[31];
    sprintf(fileName, "frame/%020" PRIu64 ".ppm", frame);
    ++frame;

    FILE *f = fopen(fileName, "wt");
    if(!f) {
        perror(fileName);
        exit(-1);
    }
    
    fprintf(f, "P3\n");
    fprintf(f, "%d %d\n", WIDTH, HEIGHT);
    fprintf(f, "255\n");

    for(int j = 0; j < HEIGHT; ++j) {
        for(int i = 0; i < WIDTH; ++i) {
            int k = ((HEIGHT - j - 1) * HEIGHT + i) * 3;
            
            fprintf(f, "%u %u %u ", (unsigned int) pixels[k], 0 /* (unsigned int) pixels[k + 1] */, (unsigned int) pixels[k + 2]);
        }
        fprintf(f, "\n");
    }
    free(pixels);
    fclose(f);
}

void write_frame() {
    FBO_2_PPM_file();
}

