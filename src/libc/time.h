#ifndef __wasm__
#   error
#endif // !__wasm__

#ifndef LIBC_TIME_H
#define LIBC_TIME_H

typedef unsigned int time_t;

time_t time(time_t *arg);

#endif // LIBC_TIME_H

