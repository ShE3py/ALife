#version 130

out vec3 color;

uniform sampler2D world;

const float PI = 3.14159265358979323846264338327950288;
const float TAU = 6.28318530717958647692528676655900577;

ivec2 ray(ivec2 origin, uint d, float phi) {
    phi *= TAU;
    vec2 delta = d * vec2(cos(phi), sin(phi));
    
    return ivec2(origin + ivec2(WIDTH, HEIGHT) + delta) % ivec2(WIDTH, HEIGHT);
}

float material(vec2 xy, uint usize) {
    int ssize = int(usize);
    
    float sum = 0;
    for(int dx = -ssize; dx <= ssize; ++dx) {
        for(int dy = -ssize; dy <= ssize; ++dy) {
            sum += texelFetch(world, ivec2(xy.x + dx + WIDTH, xy.y + dy + HEIGHT) % ivec2(WIDTH, HEIGHT), 0).b;
        }
    }
    
    return sum;
}

void main() {
    ivec2 coord = ivec2(gl_FragCoord.xy);
    
    // .r = turtle (0 ou 1)
    // .g = orientation (si turtle)
    // .b = nourriture
    vec4 data = texelFetch(world, coord, 0);
    
    color = vec3(0, 0, data.b);
    
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
    color.b = 0;
    for(int dx = -int(DIFFUSION_SIZE / 2u); dx <= int(DIFFUSION_SIZE / 2u); ++dx) {
        for(int dy = -int(DIFFUSION_SIZE / 2u); dy <= int(DIFFUSION_SIZE / 2u); ++dy) {
            color.b += texelFetch(world, (coord + ivec2(dx, dy) + ivec2(WIDTH, HEIGHT)) % ivec2(WIDTH, HEIGHT), 0).b / (DIFFUSION_SIZE * DIFFUSION_SIZE);
        }
    }
    
    // Évaporation
    color.b *= RETENTION_RATE;
    
    // Si on a une cellule
    if(color.r != 0) {
        color.b += DEPOSIT_AMOUNT;
        
        float front_material = material(ray(coord, SENSOR_DISTANCE, color.g), SENSOR_SIZE);
        float left_material = material(ray(coord, SENSOR_DISTANCE, color.g + SENSOR_ANGLE), SENSOR_SIZE);
        float right_material = material(ray(coord, SENSOR_DISTANCE, color.g - SENSOR_ANGLE), SENSOR_SIZE);
        
        if(left_material > front_material) {
            color.g += SENSOR_ANGLE;
        }
        
        if(right_material > front_material) {
            color.g -= SENSOR_ANGLE;
        }
    }
}

