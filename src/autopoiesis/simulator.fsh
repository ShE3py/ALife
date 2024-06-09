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

/**
 * Renvoie si une donnée correspond au composant O.
 */
bool eq(vec4 data, float O) {
    return abs(data.r - O) < T;
}

void main() {
    ivec2 coord = ivec2(gl_FragCoord.xy);
    
    // .r = composant (X, A, B, C, D)
    // .g = orientation (si A, B, D), normale (si C)
    // .b = catalyseur (si X, A, B, D), durée de vie restante (si C)
    vec4 data = texelFetch(world, coord, 0);
    
    color = vec3(X, data.g, 0);
    
    // Dégradation de la membrane
    if(eq(data, C)) {
        color.r = C;
        color.b = data.b - 0.005;
        
        if(color.b <= 0) {
            color.r = D;
            color.b = 0;
        }
    }
    // Propogation de la catalyse
    else {
        float d = distance(coord, CELL);
        if(d < CELL_RADIUS) {
            float alpha = acos(dot(normalize(coord - CELL), vec2(1, 0)));
            if(coord.y < CELL.y) {
                // [0,π] -> [0,τ]
                alpha = TAU - alpha;
            }
            
            ivec2 membrane = ray(CELL, CELL_RADIUS, alpha / TAU);
            if(eq(texelFetch(world, membrane, 0), C)) {
                color.b = 1 - clamp(distance(coord, membrane) / CATALYST_RANGE, 0, 1);
            }
        }
    }
    
    // Déplacement des composants
    if(eq(data, X)) {
        for(int dx = -int(COMPOUND_SPEED); dx <= int(COMPOUND_SPEED); ++dx) {
            for(int dy = -int(COMPOUND_SPEED); dy <= int(COMPOUND_SPEED); ++dy) {
                ivec2 neigh = coord + ivec2(dx, dy);
                neigh = (neigh + ivec2(WIDTH, HEIGHT)) % ivec2(WIDTH, HEIGHT);
                vec4 neighbor = texelFetch(world, neigh, 0);
                
                if(!eq(neighbor, C) && neigh != coord && ray(neigh, COMPOUND_SPEED, 1 - neighbor.g) == coord) {
                    color.rg = neighbor.rg;
                    break;
                }
            }
        }
    }
}

