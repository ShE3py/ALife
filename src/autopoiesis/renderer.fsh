#version 130

out vec3 color;

uniform sampler2D world;

// https://stackoverflow.com/a/17897228
vec3 hsv2rgb(vec3 c) {
    vec4 K = vec4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
    vec3 p = abs(fract(c.xxx + K.xyz) * 6.0 - K.www);
    return c.z * mix(K.xxx, clamp(p - K.xxx, 0.0, 1.0), c.y);
}

/**
 * Renvoie si une donnée correspond au composant O.
 */
bool eq(vec4 data, float O) {
    return abs(data.r - O) < T;
}

void main() {
    vec4 data = texelFetch(world, ivec2(gl_FragCoord.xy), 0);
    
    if(eq(data, X)) {
        color = vec3(0, 0, data.b);
    }
    else {
        color = hsv2rgb(vec3(data.r, 1, 1));
    }
}

