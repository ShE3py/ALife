#version 130

out vec3 color;

uniform sampler2D world;

void main() {
    vec4 data = texelFetch(world, ivec2(gl_FragCoord.xy), 0);
    
    color = vec3(data.r, 0, data.b);
}

