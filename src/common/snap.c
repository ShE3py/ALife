#include "snap.h"

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <inttypes.h>

#include <glad/gl.h>

#include "common/config.h"

static unsigned char *pixels;

static bool enabled;
static uint64_t filter;

const uint64_t NO_FILTER = UINT64_MAX;

__attribute__((constructor))
static void ctor(void) {
    pixels = malloc(WIDTH * HEIGHT * 3);
    if(!pixels) {
        perror("malloc");
        exit(1);
    }
    
    const char *opt = getenv("SNAP");
    if(!opt) {
        enabled = false;
    }
    else {
        enabled = true;
        if(*opt == '\0') {
            filter = NO_FILTER;
        }
        else {
            filter = strtoull(opt, NULL, 10);
        }
    }
}

__attribute__((destructor))
static void dtor(void) {
    free(pixels);
}

static bool should_snap(uint64_t frame) {
    return enabled && (filter == NO_FILTER || filter == frame);
}

// https://stackoverflow.com/a/31685135
static void FBO_2_PPM_file(void) {
    // unsigned integer overflow is defined wrapping behavior
    static uint64_t frame = UINT64_MAX;
    if(!should_snap(++frame)) {
        return;
    }
    
    glReadPixels(0, 0, WIDTH, HEIGHT, GL_RGB, GL_UNSIGNED_BYTE, pixels);
    
    // "frame/%d.ppm" => 6 + log10(2^64 - 1) + 4 + 1
    char fileName[31];
    sprintf(fileName, "frame/%020" PRIu64 ".ppm", frame);

    FILE *f = fopen(fileName, "wt");
    if(!f) {
        perror(fileName);
        enabled = false;
        return;
    }
    
    fprintf(f, "P3\n");
    fprintf(f, "%d %d\n", WIDTH, HEIGHT);
    fprintf(f, "255\n");

    for(int j = 0; j < HEIGHT; ++j) {
        for(int i = 0; i < WIDTH; ++i) {
            int k = ((HEIGHT - j - 1) * HEIGHT + i) * 3;
            
            fprintf(f, "%u %u %u ", (unsigned int) pixels[k], (unsigned int) pixels[k + 1], (unsigned int) pixels[k + 2]);
        }
        fprintf(f, "\n");
    }
    fclose(f);
    
    if(filter != NO_FILTER) {
        printf("Snapped frame %" PRIu64 "!\n", frame);
    }
}

void write_frame(void) {
    FBO_2_PPM_file();
}

