#version 130

out vec3 color;

uniform sampler2D world;

void main() {
    vec4 data = texelFetch(world, ivec2(gl_FragCoord.x - 0.5, gl_FragCoord.y - 0.5), 0);
    
    color = vec3(data.r, 0, 0);
}

