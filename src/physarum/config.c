
/**
 * La largueur de la fenêtre en pixels.
 */
const int WIDTH = 720;

/**
 * La hauteur de la fenêtre en pixels.
 */
const int HEIGHT = 720;

/**
 * Le monde est-il un tore ?
 */
const bool WRAP = true;

/**
 * Le comportement si deux cellules se déplacent sur la même cellule ;
 * `true`: l'orientation de la nouvelle cellule est la moyenne des cellules entrantes pondérée par la matière.
 * `false`: l'orientation de la nouvelle cellule est celle de la cellule entrante la plus à gauche, puis la plus en haut.
 */
const bool BOUNCE = true;

/*
 * La distance à laquelle les cellules voient.
 */
const uint SENSOR_DISTANCE = 7u;

/*
 * Angle de vision latérale des cellules, où 1 = 2π.
 */
const float SENSOR_ANGLE = 0.125;

/*
 * Côté du carré que les cellules voient.
 */
const uint SENSOR_SIZE = 10u;

/*
 * Distance que les cellules parcourent en un pas.
 */
const uint STEP_LENGTH = 3u;

/*
 * Combien de matière libèrent les cellules sur chaque case avant de se déplacer, entre 0 et 1.
 */
const float DEPOSIT_AMOUNT = 0.2;

/*
 * Sur combien de cases la matière libérée par les cellules est placée.
 */
const uint DEPOSIT_SIZE = 3u;

/*
 * Côté du carré de dispertion de la matière à chaque pas de temps.
 */
const uint DIFFUSION_SIZE = 9u;

/*
 * Taux de conservation de la matière à chaque pas de temps.
 */
const float RETENTION_RATE = 0.97;

