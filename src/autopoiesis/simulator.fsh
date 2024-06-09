#version 130

out vec3 color;

uniform sampler2D world;

const float PI = 3.14159265358979323846264338327950288;
const float TAU = 6.28318530717958647692528676655900577;

/**
 * Centre de la cellule.
 */
const ivec2 CELL = ivec2(WIDTH / 2, HEIGHT / 2);

/*
 * Projette un point `origin` vers un autre située à une distance `d` avec un angle `phi` où 1 = 2π.
 */
ivec2 ray(ivec2 origin, uint d, float phi) {
    phi *= TAU;
    vec2 delta = d * vec2(cos(phi), sin(phi));
    
    return ivec2(origin + ivec2(WIDTH, HEIGHT) + delta) % ivec2(WIDTH, HEIGHT);
}

void main() {
    ivec2 coord = ivec2(gl_FragCoord.xy);
    
    // .r = composant (X, A, B, C, D)
    // .g = orientation (si A, B, D), normale (si C)
    // .b = catalyseur
    vec4 data = texelFetch(world, coord, 0);
    
    color = vec3(data.rg, 0);
    
    // Propogation de la catalyse
    float d = distance(coord, CELL);
    if(d <= CELL_RADIUS) {
        float alpha = acos(dot(normalize(coord - CELL), vec2(1, 0)));
        if(coord.y < CELL.y) {
            // [0,π] -> [0,τ]
            alpha = TAU - alpha;
        }
        
        ivec2 membrane = ray(CELL, CELL_RADIUS, alpha / TAU);
        if(abs(texelFetch(world, membrane, 0).r - C) < A) {
            color.b = 1 - clamp(distance(coord, membrane) / CATALYST_RANGE, 0, 1);
        }
    }
}

