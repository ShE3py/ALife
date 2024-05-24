#include "codec.h"

#include <stdio.h>
#include <stdlib.h>
#include <inttypes.h>

#include <glad/gl.h>

// https://stackoverflow.com/a/31685135
void FBO_2_PPM_file() {
    int output_width = 720;
    int output_height = 480;

    unsigned char *pixels = malloc(output_width * output_height * 3);
    glReadBuffer(GL_COLOR_ATTACHMENT0);
    glReadPixels(0, 0, output_width, output_height, GL_RGB, GL_UNSIGNED_BYTE, pixels);
    
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
    fprintf(f, "%d %d\n", output_width, output_height);
    fprintf(f, "255\n");

    int k = 0;
    for(int i = 0; i < output_width; ++i) {
        for(int j = 0; j < output_height; ++j) {
            fprintf(f, "%u %u %u ", (unsigned int) pixels[k], 0 /* (unsigned int) pixels[k + 1] */, (unsigned int) pixels[k + 2]);
            k += 3;
        }
        fprintf(f, "\n");
    }
    free(pixels);
    fclose(f);
}

void write_frame() {
    FBO_2_PPM_file();
}

