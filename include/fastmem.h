/**
    libfastmem for KallistiOS ##version##

    Very optimized set of memory manipulation functions for the Sega Dreamcast.
*/

#ifndef __FASTMEM_FASTMEM_H
#define __FASTMEM_FASTMEM_H

__BEGIN_DECLS

/**
 * memset_fast: set an area of memory (optimized version for SuperH)
 *
 * This function converts the argument c into an unsigned char and fills the
 * first n characters of the array pointed to by s to the value.
 *
 * Copyright (C) 1999  Niibe Yutaka
 * Copyright (c) 2009  STMicroelectronics Ltd
 *   Optimised using 64bit data transfer (via FPU) and the movca.l inst.
 *   Author: Giuseppe Cavallaro <peppe.cavallaro@st.com>
 */
void *memset_fast(void *s, int c, size_t n);

/**
 * memcpy_fast: copy memory regions (optimized version for SuperH)
 *
 * This function copies n bytes from the memory region pointed to by src
 * to the memory region pointed to by dst.
 *
 * It is assumed that there is no overlap between src and dst.
 * If there is an overlap, then the results are undefined.
 *
 * Copyright (C) 1999  Niibe Yutaka
 * Copyright (c) 2002  STMicroelectronics Ltd
 *   Modified from memcpy.S and micro-optimised for SH4
 *   Stuart Menefy (stuart.menefy@st.com)
 * Copyright (c) 2009  STMicroelectronics Ltd
 *   Optimised using prefetching and 64bit data transfer via FPU
 *   Author: Giuseppe Cavallaro <peppe.cavallaro@st.com>
 */
void *memcpy_fast(void *dst, const void *src, size_t n);


/**
 * memmove_fast: copy memory area (optimized version for SuperH)
 * 
 * This function copies n bytes from memory area src to memory area dst.
 * The memory areas may overlap: copying takes place as though the bytes in src
 * are first copied into a temporary array that does not overlap src or dst,
 * and the bytes are then copied from the temporary array to dst.
 *
 * Copyright (C) 1999  Niibe Yutaka
 */
void *memmove_fast(void *dst, const void *src, size_t n);

__END_DECLS

#endif	/* __FASTMEM_FASTMEM_H */
