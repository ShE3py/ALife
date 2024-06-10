# ALife

Les différents programmes ont étés écrit en C et en GLSL (OpenGL 3.0).

## Compilation

Le programme requiert GNU Make, GCC, et GLFW.
Pour GLFW, si vous n'êtes pas sous Linux, il faudra probablement rajouter `-I<le dossier>` dans le `CFLAGS` du `Makefile`.

```
make
./physarum
./autopoiesis
```

J'ai utilisé GLAD pour charger les fonctions d'OpenGL, la 1re compilation peut prendre quelques secondes.

## Paramètres

Les paramètres sont définis dans `src/physarum/config.c` et `src/autopoiesis/config.c`.
Il faudra ensuite recompiler le programme avec `make`.

