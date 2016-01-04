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
#ifeq ($(TRAVIS),)
	#
	# put here all the targets that for a reason or another break on travis
	#
  LIBS=-lcsnd6 -lcsound64
  BROKEN_TRAVIS_TARGETS = csound_version csound_API_version
#endif

TARGETS=sizeof_CSOUND_PARAMS sizeof_MYFLT $(BROKEN_TRAVIS_TARGETS)
SOURCES=$(TARGETS:=.c)
TOP=../../..
EXTPATH=$(TOP)/ext
CS6MAKEDIR=$(EXTPATH)/cs6make
CSOUNDDIR=$(EXTPATH)/csound
CC=gcc
CFLAGS=-Wall -g -I$(CS6MAKEDIR)/include -I$(CSOUNDDIR)/include
LDFLAGS=-L$(CS6MAKEDIR) $(LIBS)

all: $(TARGETS)

clean:
	$(RM) $(TARGETS) $(SOURCES:.c=.$(OSFX))

.PHONY: clean
