/* $Id: memset.S,v 1.1 2000/04/14 16:49:01 mjd Exp $
 *
 * "memset" implementation of SuperH
 *
 * Copyright (C) 1999  Niibe Yutaka
 *
 * Copyright (c) 2009  STMicroelectronics Ltd
 *   Optimised using 64bit data transfer (via FPU) and the movca.l inst.
 *   Author: Giuseppe Cavallaro <peppe.cavallaro@st.com>
 *
 * Licensed under the LGPL v2.1, see the file COPYING.LIB in this tarball.
 */

/*
 *            void *memset_fast(void *s, int c, size_t n);
 */

#include "asm.h"

#if defined (__LITTLE_ENDIAN__) && defined (__SH_FPU_ANY__)
#define MEMSET_USES_FPU
/* Use paired single precision load or store mode for 64-bit tranfering.
 * FPSCR.SZ=1,FPSCR.SZ=0 is well defined on both SH4-200 and SH4-300.
 * Currenlty it has been only implemented and tested for little endian mode. */
.macro FPU_SET_PAIRED_PREC
#if defined(__SH4_SINGLE_ONLY__) || defined(__SH4_SINGLE__)
	fschg
#else
	sts	fpscr, r3
	mov	#0x10, r1	! PR=0 SZ=1
	shll16  r1
	lds	r1, fpscr
#endif
.endm
.macro RESTORE_FPSCR
#if defined(__SH4_SINGLE_ONLY__) || defined(__SH4_SINGLE__)
	fschg
#else
	lds	r3, fpscr
#endif
.endm
#endif

ENTRY(memset_fast)
	mov	#12,r0
	add	r6,r4
	cmp/gt	r6,r0
	bt/s	40f		! if it's too small, set a byte at once
	 mov	r4,r0
	and	#3,r0
	cmp/eq	#0,r0
	bt/s	2f		! It's aligned
	 sub	r0,r6
1:
	dt	r0
	bf/s	1b
	 mov.b	r5,@-r4
2:				! make VVVV
	extu.b	r5,r5
	swap.b	r5,r0		!   V0
	or	r0,r5		!   VV
	swap.w	r5,r0		! VV00
	or	r0,r5		! VVVV

	! Check if enough bytes need to be copied to be worth the big loop
	mov	#0x40, r0	! (MT)
	cmp/gt	r6,r0		! (MT)  64 > len => slow loop

	bt/s	22f
	 mov	r6,r0

	! align the dst to the cache block size if necessary
	mov	#0x1f, r1

	and	r4, r1
	tst	r1, r1

	bt/s	11f		! dst is already aligned
	 shlr2	r1		! number of loops

10:	mov.l	r5,@-r4
	dt	r1
	bf/s	10b
	 add	#-4, r6

11:	! dst is 32byte aligned
	mov	r6,r2
	mov	#-5,r0
	shld	r0,r2		! number of loops

	add	#-32, r4
	mov	r5, r0

#ifdef MEMSET_USES_FPU
	lds	r5, fpul	! (CO)
	fsts	fpul, fr0	! Dr0 will be 'VVVVVVVV'
	fsts	fpul, fr1

	FPU_SET_PAIRED_PREC
12:
	movca.l	r0, @r4
	mov.l	r5, @(4, r4)
	add	#32, r4
	fmov	dr0, @-r4
	fmov	dr0, @-r4
	add	#-0x20, r6
	fmov	dr0, @-r4
	dt	r2
	bf/s	12b
	 add	#-40, r4

	RESTORE_FPSCR
#else
12:
	movca.l	r0,@r4
	mov.l	r5,@(4, r4)
	mov.l	r5,@(8, r4)
	mov.l	r5,@(12,r4)
	mov.l	r5,@(16,r4)
	mov.l	r5,@(20,r4)
	add	#-0x20, r6
	mov.l	r5,@(24,r4)
	dt	r2
	mov.l	r5,@(28,r4)
	bf/s	12b
	 add	#-32, r4

#endif
	add	#32, r4
	mov	#8, r0
	cmp/ge	r0, r6
	bf	40f

	mov	r6,r0
22:
	shlr2	r0
	shlr	r0		! r0 = r6 >> 3
3:
	dt	r0
	mov.l	r5,@-r4		! set 8-byte at once
	bf/s	3b
	 mov.l	r5,@-r4
	!
	mov	#7,r0
	and	r0,r6

	! fill bytes (length may be zero)
40:	tst	r6,r6
	bt	5f
4:
	dt	r6
	bf/s	4b
	 mov.b	r5,@-r4
5:
	rts
	 mov	r4,r0
