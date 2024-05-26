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
    
    if(WRAP) {
        return ivec2(origin + ivec2(WIDTH, HEIGHT) + delta) % ivec2(WIDTH, HEIGHT);
    }
    else {
        return origin + ivec2(delta);
    }
}

/*
 * Renvoie la somme totale de matériel dans le rayon du capteur autour du point spécifié.
 */
float material(vec2 xy) {
    int ssize = int(SENSOR_SIZE / 2u);
    
    float sum = 0;
    for(int dx = -ssize; dx <= ssize; ++dx) {
        for(int dy = -ssize; dy <= ssize; ++dy) {
            ivec2 pos = ivec2(xy) + ivec2(dx, dy);
            if(WRAP) {
                pos = (pos + ivec2(WIDTH, HEIGHT)) % ivec2(WIDTH, HEIGHT);
            }
            sum += texelFetch(world, pos, 0).b;
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
    
    color = vec3(0, 0, -1);
    
    // Déplacement des cellules
    for(int dx = -int(STEP_LENGTH); dx <= int(STEP_LENGTH); ++dx) {
        for(int dy = -int(STEP_LENGTH); dy <= int(STEP_LENGTH); ++dy) {
            ivec2 neigh = coord + ivec2(dx, dy);
            if(WRAP) {
                neigh = (neigh + ivec2(WIDTH, HEIGHT)) % ivec2(WIDTH, HEIGHT);
            }
            vec4 neighbor = texelFetch(world, neigh, 0);
            
            if(neighbor.r != 0 && neigh != coord && ray(neigh, STEP_LENGTH, 1 - neighbor.g) == coord) {
                color.g = (color.r == 0) ? neighbor.g : (color.g * color.b + neighbor.g * neighbor.b) / (color.b + neighbor.b);
                color.b = (color.b == -1) ? neighbor.b : (color.b + neighbor.b) / 2;
                color.r = 1;
                if(!BOUNCE) {
                    // équivaut à `color.rg = neighbor.rg`
                    break;
                }
            }
        }
    }
    color.b = 0;
    
    // Tourner la cellule si celle-ci sortira du monde
    if(!WRAP && data.r != 0) {
        ivec2 next = ray(coord, STEP_LENGTH, data.g);
        if(next.x < 0 || next.x > WIDTH || next.y < 0 || next.y > HEIGHT) {
            color.r = data.r;
            color.g = 1 - data.g;
        }
    }
    
    // Diffusion
    for(int dx = -int(DIFFUSION_SIZE / 2u); dx <= int(DIFFUSION_SIZE / 2u); ++dx) {
        for(int dy = -int(DIFFUSION_SIZE / 2u); dy <= int(DIFFUSION_SIZE / 2u); ++dy) {
            ivec2 pos = coord + ivec2(dx, dy);
            if(WRAP) {
                pos = (pos + ivec2(WIDTH, HEIGHT)) % ivec2(WIDTH, HEIGHT);
            }
            color.b += texelFetch(world, pos, 0).b / (DIFFUSION_SIZE * DIFFUSION_SIZE);
        }
    }
    
    // Évaporation
    color.b *= RETENTION_RATE;
    
    // Dépôt
    for(int dx = -int(DEPOSIT_SIZE / 2u); dx <= int(DEPOSIT_SIZE / 2u); ++dx) {
        for(int dy = -int(DEPOSIT_SIZE / 2u); dy <= int(DEPOSIT_SIZE / 2u); ++dy) {
            ivec2 pos = coord + ivec2(dx, dy);
            if(WRAP) {
                pos = (pos + ivec2(WIDTH, HEIGHT)) % ivec2(WIDTH, HEIGHT);
            }
            vec4 neighbor = texelFetch(world, pos, 0);
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

