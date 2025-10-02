
# Minimal Makefile intended for non-interactive use (eg. shards postinstall)
# Builds only a static library libminiaudio.a inside ext/miniaudio.
# Keep it tiny and reliable; do not modify ext/miniaudio source files.

MINIAUDIO_DIR := $(CURDIR)/miniaudio
SRC := $(MINIAUDIO_DIR)/miniaudio.c
OBJDIR := $(MINIAUDIO_DIR)/build
OBJ := $(OBJDIR)/miniaudio.o
STATIC := $(MINIAUDIO_DIR)/libminiaudio.a

CC ?= cc
AR ?= ar
CFLAGS ?= -O2 -fPIC -std=c99

.PHONY: all clean

all: $(STATIC)

$(OBJDIR):
	mkdir -p $(OBJDIR)

$(OBJ): $(SRC) | $(OBJDIR)
	$(CC) $(CFLAGS) -c $(SRC) -o $(OBJ)

$(STATIC): $(OBJ)
	$(AR) rcs $(STATIC) $(OBJ)

clean:
	-rm -f $(OBJ) $(STATIC)
	-rm -rf $(OBJDIR)

