
/**
 * La largueur de la fenêtre en pixels.
 */
const int WIDTH = 720;

/**
 * La hauteur de la fenêtre en pixels.
 */
const int HEIGHT = 480;

/**
 * Le monde est-il un tore ?
 */
const bool WRAP = false;

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
const uint SENSOR_SIZE = 5u;

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

