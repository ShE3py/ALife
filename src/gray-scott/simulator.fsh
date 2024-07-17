#version 130

out vec3 color;

uniform sampler2D world;

void main() {
    ivec2 coord = ivec2(gl_FragCoord.xy);
    
    // .r = concentration de A
    // .g = concentration de B
    vec4 data = texelFetch(world, coord, 0);
    
    color = data.xyz;
}

