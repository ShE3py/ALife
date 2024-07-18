#version 130

out vec3 color;

uniform sampler2D world;

/**
 * Feed/kill rates.
 */
uniform float f, k;

/**
 * The diffusion rate of the chemical species.
 */
uniform float ru, rv;

/**
 * The discretized time step.
 */
uniform float Dt;

// Moore neighborhood
vec2 laplacian(ivec2 coord) {
    vec2 sum = vec2(0.0);
    
    const float CONVOLUTION[9] = float[] (
        0.05, 0.20, 0.05,
        0.20, -1.0, 0.20,
        0.05, 0.20, 0.05
    );
    
    for(int dx = -1; dx <= 1; ++dx) {
        for(int dy = -1; dy <= 1; ++dy) {
            ivec2 koord = coord + ivec2(dx, dy);
            if(TEX_WRAP) {
                koord = (koord + ivec2(WIDTH, HEIGHT)) % ivec2(WIDTH, HEIGHT);
            }
            
            sum += texelFetch(world, koord, 0).rg * CONVOLUTION[dx + 1 + (dy + 1) * 3];
        }
    }
    
    return sum;
}

void main() {
    ivec2 coord = ivec2(gl_FragCoord.xy);
    
    // .r = concentration de U
    // .g = concentration de V
    vec4 data = texelFetch(world, coord, 0);
    float u = data.r;
    float v = data.g;
    
    vec2 laplace = laplacian(coord);
    float U = u + ((ru * laplace.r) - (u * v * v) + (     f  * (1.0 - u))) * Dt;
    float V = v + ((rv * laplace.g) + (u * v * v) - ((k + f) *        v )) * Dt;
    
    color = vec3(U, V, 0);
}

