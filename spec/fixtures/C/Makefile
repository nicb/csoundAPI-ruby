#
# Makefile that compiles all testing fixtures
#
#
# default value for OS_NAME
#
OS_NAME = linux

ifeq ($(OS_NAME), linux)
  SUFFIX = so
	OSFX = o
endif
ifeq ($(OS_NAME), osx)
  SUFFIX = dylib
	OSFX = o
endif

TARGETS=sizeof_CSOUND_PARAMS sizeof_MYFLT csound_version csound_API_version
SOURCES=$(TARGETS:=.c)
TOP=../../..
EXTPATH=$(TOP)/ext
CS6MAKEDIR=$(EXTPATH)/cs6make
CSOUNDDIR=$(EXTPATH)/csound
CC=gcc
CFLAGS=-Wall -g -I$(CS6MAKEDIR)/include -I$(CSOUNDDIR)/include
LDFLAGS=-L$(CS6MAKEDIR) $(LIBS)
LIBS=-lcsnd6 -lcsound64

all: $(TARGETS)

clean:
	$(RM) $(TARGETS) $(SOURCES:.c=.$(OSFX))

.PHONY: clean
