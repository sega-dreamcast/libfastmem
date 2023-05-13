# libfastmem for KallistiOS ##version##
#
# Makefile


TARGET = libfastmem.a
OBJS = memcpy_fast.o memset_fast.o memmove_fast.o

defaultall: create_kos_link $(OBJS) subdirs linklib

include $(KOS_BASE)/addons/Makefile.prefab

# creates the kos link to the headers
create_kos_link:
	rm -f ../include/fastmem
	ln -s ../libfastmem/include ../include/fastmem
