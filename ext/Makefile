# Minimal Makefile for postinstall: builds a static library for POSIX/MinGW or MSVC.
MINIAUDIO_DIR := $(CURDIR)/miniaudio
SRC := $(MINIAUDIO_DIR)/miniaudio.c
OBJDIR := $(MINIAUDIO_DIR)/build

# POSIX targets
OBJ_UNIX := $(OBJDIR)/miniaudio.o
STATIC_UNIX := $(MINIAUDIO_DIR)/libminiaudio.a

# MSVC targets
OBJ_MSVC := $(OBJDIR)/miniaudio.obj
LIB_MSVC := $(MINIAUDIO_DIR)/miniaudio.lib

CC ?= cc
AR ?= ar
CFLAGS ?= -O2 -fPIC -std=c99

# Detect MSVC (cl) in PATH. On Unix shells this tries `command -v cl`.
CL := $(shell command -v cl 2>/dev/null || true)

.PHONY: all clean

ifeq ($(CL),)
# POSIX / MinGW path (uses cc/ar)
all: $(STATIC_UNIX)

$(OBJDIR):
	mkdir -p $(OBJDIR)

$(OBJ_UNIX): $(SRC) | $(OBJDIR)
	$(CC) $(CFLAGS) -c $(SRC) -o $(OBJ_UNIX)

$(STATIC_UNIX): $(OBJ_UNIX)
	$(AR) rcs $(STATIC_UNIX) $(OBJ_UNIX)

else
# MSVC path (requires Visual Studio dev environment active)
all: $(LIB_MSVC)

$(OBJDIR):
	mkdir -p $(OBJDIR)

$(OBJ_MSVC): $(SRC) | $(OBJDIR)
	cl /nologo /O2 /MD /W3 /c "$(SRC)" /Fo"$(OBJ_MSVC)"

$(LIB_MSVC): $(OBJ_MSVC)
	lib /nologo /OUT:"$(LIB_MSVC)" "$(OBJ_MSVC)"

endif

clean:
	-rm -f $(OBJ_UNIX) $(STATIC_UNIX)
	-rm -f $(OBJ_MSVC) $(LIB_MSVC)
	-rm -rf $(OBJDIR)

