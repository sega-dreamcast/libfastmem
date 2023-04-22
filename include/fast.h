/*
    libfast for KallistiOS ##version##   
*/

#ifndef __FAST_FAST_H
#define __FAST_FAST_H

__BEGIN_DECLS

/**
 * memset_fast: set an area of memory (optimized version for SuperH)
 *
 * This function converts the argument c into an unsigned char and fills the
 * first n characters of the array pointed to by s to the value.
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
 */
void *memcpy_fast(void *dst, const void *src, size_t n);

__END_DECLS

#endif	/* __FAST_FAST_H */
