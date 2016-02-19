# Global overrides
SHELL      = /bin/bash -e
CC         = gcc
CXX        = g++
FC         = gfortran
AR         = ar
GIT        = git
SED        = sed
CURL       = curl
CMAKE      = cmake
UNAME      = uname
MD5SUM     = md5sum
SHA1SUM    = sha1sum
PERL       = perl

PFHOME    := $(realpath ../../..)

-include $(PFHOME)/settings.mk

WORKSPACE  ?= $(PFHOME)/workspace
PREFIX     ?= $(PFHOME)/deployment
STAGING    ?= $(PFHOME)/staging
CCACHE_DIR ?= $(WORKSPACE)/.ccache
PIP         = $(PREFIX)/bin/pip --no-cache-dir

ifneq ($(origin DEBUG),undefined)
    export DEBUG=yes
    VERBOSE=1
endif

ARCH      := $(shell $(UNAME) -m)
OPSYS     := $(shell $(UNAME) -s)

LDFLAGS    = -L$(PREFIX)/lib
CFLAGS     = -fPIC
CFLAGS    += -I$(PREFIX)/include
CXXFLAGS   = $(CFLAGS)

BOOST_INC = $(PREFIX)/include

HDF5_ROOT = $(PREFIX)

ifeq ($(OPSYS),Darwin)
    HAVE_ZLIB = /usr
endif

ZLIB_ROOT = $(PREFIX)

export CC
export CXX
export FC
export CCACHE_DIR
export PATH              := $(PREFIX)/bin:$(PFHOME)/bin:${PATH}
ifeq ($(OPSYS),Darwin)
    DYLIB  = dylib
    export DYLD_LIBRARY_PATH := $(PREFIX)/lib:${DYLD_LIBRARY_PATH}
else
    DYLIB  = so
    export LD_LIBRARY_PATH   := $(PREFIX)/lib:${LD_LIBRARY_PATH}
endif
export PKG_CONFIG_PATH   := $(PREFIX)/lib/pkgconfig

