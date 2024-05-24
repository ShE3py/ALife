#version 130

out vec3 color;

uniform sampler2D world;

const float PI = 3.14159265358979323846264338327950288;
const float TAU = 6.28318530717958647692528676655900577;

/*
 * Projette un point `origin` vers un autre située à une distance `d` avec un angle `phi` où 1 = 2π.
 */
ivec2 ray(ivec2 origin, uint d, float phi) {
    phi *= TAU;
    vec2 delta = d * vec2(cos(phi), sin(phi));
    
    return ivec2(origin + ivec2(WIDTH, HEIGHT) + delta) % ivec2(WIDTH, HEIGHT);
}

/*
 * Renvoie la somme totale de matériel dans le rayon du capteur autour du point spécifié.
 */
float material(vec2 xy) {
    int ssize = int(SENSOR_SIZE);
    
    float sum = 0;
    for(int dx = -ssize; dx <= ssize; ++dx) {
        for(int dy = -ssize; dy <= ssize; ++dy) {
            sum += texelFetch(world, ivec2(xy.x + dx + WIDTH, xy.y + dy + HEIGHT) % ivec2(WIDTH, HEIGHT), 0).b;
        }
    }
    
    return sum;
}

float random(vec2 st) {
    return fract(sin(dot(st.xy, vec2(12.9898,78.233))) * 43758.5453123);
}

void main() {
    ivec2 coord = ivec2(gl_FragCoord.xy);
    
    // .r = turtle (0 ou 1)
    // .g = orientation (si turtle)
    // .b = nourriture
    vec4 data = texelFetch(world, coord, 0);
    
    color = vec3(0);
    
    // Déplacement des cellules
    for(int dx = -int(STEP_LENGTH); dx <= int(STEP_LENGTH); ++dx) {
        for(int dy = -int(STEP_LENGTH); dy <= int(STEP_LENGTH); ++dy) {
            ivec2 neigh = (coord + ivec2(dx, dy) + ivec2(WIDTH, HEIGHT)) % ivec2(WIDTH, HEIGHT);
            vec4 neighbor = texelFetch(world, neigh, 0);
            
            if(neighbor.r != 0 && neigh != coord && ray(neigh, STEP_LENGTH, 1 - neighbor.g) == coord) {
                color.rg = neighbor.rg;
                break;
            }
        }
    }
    
    // Diffusion
    for(int dx = -int(DIFFUSION_SIZE / 2u); dx <= int(DIFFUSION_SIZE / 2u); ++dx) {
        for(int dy = -int(DIFFUSION_SIZE / 2u); dy <= int(DIFFUSION_SIZE / 2u); ++dy) {
            color.b += texelFetch(world, (coord + ivec2(dx, dy) + ivec2(WIDTH, HEIGHT)) % ivec2(WIDTH, HEIGHT), 0).b / (DIFFUSION_SIZE * DIFFUSION_SIZE);
        }
    }
    
    // Évaporation
    color.b *= RETENTION_RATE;
    
    // Dépôt
    for(int dx = -int(DEPOSIT_SIZE / 2u); dx <= int(DEPOSIT_SIZE / 2u); ++dx) {
        for(int dy = -int(DEPOSIT_SIZE / 2u); dy <= int(DEPOSIT_SIZE / 2u); ++dy) {
            vec4 neighbor = texelFetch(world, (coord + ivec2(dx, dy) + ivec2(WIDTH, HEIGHT)) % ivec2(WIDTH, HEIGHT), 0);
            if(neighbor.r != 0) {
                color.b += DEPOSIT_AMOUNT;
            }
        }
    }
    
    // Changement d'orientation
    if(color.r != 0) {
        float front_material = material(ray(coord, SENSOR_DISTANCE, color.g));
        float left_material = material(ray(coord, SENSOR_DISTANCE, color.g + SENSOR_ANGLE));
        float right_material = material(ray(coord, SENSOR_DISTANCE, color.g - SENSOR_ANGLE));
        
        if(left_material > front_material) {
            color.g += SENSOR_ANGLE;
        }
        else if(right_material > front_material) {
            color.g -= SENSOR_ANGLE;
        }
        else if(front_material < 0.1) {
            color.g += random(coord / vec2(WIDTH, HEIGHT));
        }
    }
}

