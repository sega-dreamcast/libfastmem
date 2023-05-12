# libfastmem

Very optimized set of memory manipulation functions for the Sega Dreamcast.

## Introduction

**libfastmem** is a tiny library for [KallistiOS](http://gamedev.allusion.net/softprj/kos/)
that provides set of functions dedicated to memory manipulation, that are very
optimized in terms of speed and/or memory. These functions can be used in
remplacement of standard functions, but keep in mind that all functions provided
in that library are suffixed with the `_fast` prefix.

This library is intended to be used as a KallistiOS Port (`kos-ports`) but it
can be used as a KallistiOS add-on as well.

## Available functions

You need to include `<fastmem/fastmem.h>` in your project.

This library ship 3 functions:

* `memset_fast`
* `memcpy_fast`
* `memmove_fast`

### memset_fast

Set an area of memory.

```
void *memset_fast(void *s, int c, size_t n);
```

This function converts the argument `c` into an unsigned char and fills the
first `n` characters of the array pointed to by `s` to the value.

### memcpy_fast

Copy memory regions.

```
void *memcpy_fast(void *dst, const void *src, size_t n);
```

This function copies `n` bytes from the memory region pointed to by `src` to the
memory region pointed to by `dst`. It is assumed that there is no overlap
between `src` and `dst`. If there is an overlap, then the results are undefined.

### memmove_fast

Copy memory area.

```
void *memmove_fast(void *dst, const void *src, size_t n);
```

This function copies `n` bytes from memory area `src` to memory area `dst`.
The memory areas may overlap: copying takes place as though the bytes in `src`
are first copied into a temporary array that does not overlap `src` or `dst`,
and the bytes are then copied from the temporary array to `dst`.

## Credits

### memset_fast

Copyright (C) 1999  [Niibe Yutaka](http://www.gniibe.org/)

Copyright (c) 2009  [STMicroelectronics Ltd](https://www.st.com)
> Optimized using 64bit data transfer (via FPU) and the `movca.l` inst.
> Author: Giuseppe Cavallaro <peppe.cavallaro@st.com>

### memcpy_fast

Copyright (C) 1999  [Niibe Yutaka](http://www.gniibe.org/)

Copyright (c) 2002  [STMicroelectronics Ltd](https://www.st.com)
> Modified from `memcpy.S` and micro-optimized for SH4
> Author: Stuart Menefy (stuart.menefy@st.com)

Copyright (c) 2009  [STMicroelectronics Ltd](https://www.st.com)
> Optimized using prefetching and 64bit data transfer via FPU
> Author: Giuseppe Cavallaro (peppe.cavallaro@st.com)

### memmove_fast

Copyright (C) 1999  [Niibe Yutaka](http://www.gniibe.org/)

## About

These functions were intended to be directly merged in KallistiOS patches but
unfortunately, [this couldn't be done due to licensing issue](https://github.com/KallistiOS/KallistiOS/pull/157).
These functions remain very interesting for Sega Dreamcast programming, that's
why these were published in that library.
