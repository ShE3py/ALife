#version 130

out vec3 color;

uniform sampler2D world;

const float PI = 3.14159265358979323846264338327950288;
const float TAU = 6.28318530717958647692528676655900577;

// Distance à laquelle les tortues voient
const uint sensor_distance = 1u;

// Angle de vision latérale des tortues
const float sensor_angle = 0.125;

// Côté du carré de patchs que les tortues voient
const uint sensor_size = 3u;

// Distance que les tortues parcourent en un pas
const uint step_length = 1u;

// Combien de matériaux libèrent les tortues avant de se déplacer
const float deposite_amount = 1;

// Sur combien de patchs les matériaux libérés par les tortues sont placés
const uint deposite_size = 1u;

// Côté du carré de dispertion des matériaux sur les patches
const uint diffuze_size = 3u;

// Taux de déterioration des matérieux sur les patches
const float decay_factor = 0.97;

ivec2 ray(ivec2 origin, uint d, float phi) {
    phi *= TAU;
    vec2 delta = d * vec2(cos(phi), sin(phi));
    
    return ivec2(origin + ivec2(720, 480) + delta) % ivec2(720, 480);
}

float material(vec2 xy, uint usize) {
    int ssize = int(usize);
    
    float sum = 0;
    for(int dx = -ssize; dx <= ssize; ++dx) {
        for(int dy = -ssize; dy <= ssize; ++dy) {
            sum += texelFetch(world, ivec2(xy.x + dx + 720, xy.y + dy + 480) % ivec2(720, 480), 0).b;
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
    for(int dx = -int(step_length); dx <= int(step_length); ++dx) {
        for(int dy = -int(step_length); dy <= int(step_length); ++dy) {
            ivec2 neigh = (coord + ivec2(dx, dy) + ivec2(720, 480)) % ivec2(720, 480);
            vec4 neighbor = texelFetch(world, neigh, 0);
            
            if(neighbor.r != 0 && neigh != coord && ray(neigh, step_length, 1 - neighbor.g) == coord) {
                color.rg = neighbor.rg;
                break;
            }
        }
    }
    
    // Diffusion
    color.b = 0;
    for(int dx = -int(diffuze_size / 2u); dx <= int(diffuze_size / 2u); ++dx) {
        for(int dy = -int(diffuze_size / 2u); dy <= int(diffuze_size / 2u); ++dy) {
            color.b += texelFetch(world, (coord + ivec2(dx, dy) + ivec2(720, 480)) % ivec2(720, 480), 0).b / (diffuze_size * diffuze_size);
        }
    }
    
    // Évaporation
    color.b *= decay_factor;
    
    // Si on a une cellule
    if(color.r != 0) {
        color.b += deposite_amount;
        
        float front_material = material(ray(coord, sensor_distance, color.g), sensor_size);
        float left_material = material(ray(coord, sensor_distance, color.g + sensor_angle), sensor_size);
        float right_material = material(ray(coord, sensor_distance, color.g - sensor_angle), sensor_size);
        
        if(left_material > front_material) {
            color.g += sensor_angle;
        }
        
        if(right_material > front_material) {
            color.g -= sensor_angle;
        }
    }
}

