#version 130

out vec3 color;

uniform sampler2D world;

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
            ivec2 koord = (coord + ivec2(dx, dy) + ivec2(WIDTH, HEIGHT)) % ivec2(WIDTH, HEIGHT);
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
    float U = u + ((DIFFUSION_RATE_U * laplace.r) - (u * v * v) + (                FEED_RATE_F  * (1.0 - u))) * DELTA_T;
    float V = v + ((DIFFUSION_RATE_V * laplace.g) + (u * v * v) - ((DECAY_RATE_K + FEED_RATE_F) *        v )) * DELTA_T;
    
    color = vec3(U, V, 0);
}

