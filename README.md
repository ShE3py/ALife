# ALife

Les différents programmes ont étés écrit en C et en GLSL (OpenGL 3.0). L'analyse des automates est disponible dans `doc/`.

Une version en ligne du blob est disponible à l'adresse <https://she3py.github.io/ALife/www/physarum.html>.

## Compilation

Le programme requiert GNU Make, GCC, et GLFW.

Pour GLFW, si vous n'êtes pas sous Linux, il faudra probablement rajouter `-I<le dossier>` dans le `CFLAGS` du `Makefile`.

```
make clean # pour créer certains dossiers
make
./physarum
./autopoiesis
```

GLAD a été utilisé pour charger les fonctions d'OpenGL, la 1re compilation peut prendre quelques secondes.

## Paramètres

Les paramètres sont définis dans `src/physarum/config.c` et `src/autopoiesis/config.c`.
Il faudra ensuite recompiler le programme avec `make`.

