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
    vec4 self = texelFetch(world, coord, 0);
    
    color = vec3(X, self.g, 0);
    
    // Dégradation de la membrane
    if(eq(self, C)) {
        color.r = C;
        color.b = self.b - MEMBRANE_DEGRADATION_SPEED;
        
        if(color.b <= 0) {
            color.r = D;
            color.b = 0;
        }
    }
    // Calcul du rayon d'action de la catalyse
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
    
    // A + A + catalyse → B
    if(eq(self, A)) {
        if(color.b > 0.1) {
            color.r = B;
            self.r = B;
        }
    }
    
    // Déplacement des composants
    if(!eq(self, C)) {
        for(int dx = -int(COMPOUND_SPEED); dx <= int(COMPOUND_SPEED); ++dx) {
            for(int dy = -int(COMPOUND_SPEED); dy <= int(COMPOUND_SPEED); ++dy) {
                ivec2 neigh = coord + ivec2(dx, dy);
                neigh = (neigh + ivec2(WIDTH, HEIGHT)) % ivec2(WIDTH, HEIGHT);
                vec4 neighbor = texelFetch(world, neigh, 0);
                
                if(!eq(neighbor, C) && !eq(neighbor, X) && neigh != coord && ray(neigh, COMPOUND_SPEED, 1 - neighbor.g) == coord) {
                    // Si collision de plusieurs particules, B > A > D
                    if(eq(neighbor, B)) {
                        color.rg = neighbor.rg;
                        break;
                    }
                    
                    if(eq(neighbor, D)) {
                        // `==` car D réécrit seulement si aucun composant
                        // n'a changé, c.-à-d. que l'on ait la valeur initiale X
                        if(color.r == X) {
                            color.rg = neighbor.rg;
                        }
                        
                        continue;
                    }
                    
                    // Reste: A
                    if(!eq(vec4(color, 1), B)) {
                        color.rg = neighbor.rg;
                    }
                }
            }
        }
    }
    
    // B -> C
    if(abs(distance(coord, CELL) - CELL_RADIUS) < 1 && eq(vec4(color, 1), X)) {
        for(int dx = -5; dx <= 5; ++dx) {
            for(int dy = -5; dy <= 5; ++dy) {
                ivec2 neigh = coord + ivec2(dx, dy);
                neigh = (neigh + ivec2(WIDTH, HEIGHT)) % ivec2(WIDTH, HEIGHT);
                vec4 neighbor = texelFetch(world, neigh, 0);
                
                if(eq(neighbor, B)) {
                    color.r = C;
                    color.b = 1;
                }
            }
        }
    }
    
    // B ne peut pas traverser la membrane
    if(eq(vec4(color, 1), B)) {
        ivec2 next = ray(coord, COMPOUND_SPEED, color.g);
        
        if(distance(next, CELL) >= CELL_RADIUS) {
            float g = color.g - 0.5;
            if(g < 0) g += 1;
            color.g = g;
        }
        
        // Tue les B qui se sont échappées de la membrane
        if(distance(coord, CELL) >= CELL_RADIUS) {
            color.r = X;
        }
    }
}

