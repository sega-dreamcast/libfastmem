# libfast for KallistiOS ##version##
#
# Makefile

TARGET = libfast.a
OBJS = memcpy_fast.o memset_fast.o

defaultall: create_kos_link $(OBJS) subdirs linklib

include $(KOS_BASE)/addons/Makefile.prefab

# creates the kos link to the headers
create_kos_link:
	rm -f ../include/fast
	ln -s ../libfast/include ../include/fast
