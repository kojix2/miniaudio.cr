# Minimal Makefile for postinstall: builds a static library for POSIX/MinGW or MSVC.

MINIAUDIO_DIR := $(CURDIR)/miniaudio
SRC           := $(MINIAUDIO_DIR)/miniaudio.c
OBJDIR        := $(MINIAUDIO_DIR)/build

# POSIX targets
OBJ_UNIX      := $(OBJDIR)/miniaudio.o
STATIC_UNIX   := $(MINIAUDIO_DIR)/libminiaudio.a

# MSVC targets
OBJ_MSVC      := $(OBJDIR)/miniaudio.obj
LIB_MSVC      := $(MINIAUDIO_DIR)/miniaudio.lib

CC      ?= cc
AR      ?= ar
CSTD    ?= -std=c99
OPT     ?= -O2

# Detect uname for deciding PIC flag (safe even on Windows bash).
UNAME_S := $(shell uname -s 2>/dev/null || echo Unknown)

# Use -fPIC only on ELF-ish systems (not on Windows toolchains).
ifeq ($(findstring MINGW,$(UNAME_S))$(findstring MSYS,$(UNAME_S))$(findstring CYGWIN,$(UNAME_S)),)
  PICFLAG := -fPIC
else
  PICFLAG :=
endif

CFLAGS ?= $(OPT) $(CSTD) $(PICFLAG)

# Tools
MKDIR_P := mkdir -p
RM_F    := rm -f
RM_RF   := rm -rf

.PHONY: all clean
.SUFFIXES:
.DELETE_ON_ERROR:

# Detect MSVC by presence of Visual Studio environment variables.
ifneq ($(VCINSTALLDIR)$(VSINSTALLDIR)$(VisualStudioVersion)$(VSCMD_VER),)
  all: $(LIB_MSVC)

  $(OBJDIR):
	$(MKDIR_P) "$(OBJDIR)"

  MSVC_CFLAGS ?= -nologo -O2 -MD -W3

  $(OBJ_MSVC): $(SRC) | $(OBJDIR)
	cl $(MSVC_CFLAGS) -c "$(SRC)" -Fo"$(OBJ_MSVC)"

  $(LIB_MSVC): $(OBJ_MSVC)
	lib -nologo -OUT:"$(LIB_MSVC)" "$(OBJ_MSVC)"

else
  # POSIX / MinGW path (cc + ar)
  all: $(STATIC_UNIX)

  $(OBJDIR):
	$(MKDIR_P) "$(OBJDIR)"

  $(OBJ_UNIX): $(SRC) | $(OBJDIR)
	$(CC) $(CFLAGS) -c "$(SRC)" -o "$(OBJ_UNIX)"

  $(STATIC_UNIX): $(OBJ_UNIX)
	$(AR) rcs "$(STATIC_UNIX)" "$(OBJ_UNIX)"

endif

clean:
	-$(RM_F)  "$(OBJ_UNIX)" "$(STATIC_UNIX)"
	-$(RM_F)  "$(OBJ_MSVC)" "$(LIB_MSVC)"
	-$(RM_RF) "$(OBJDIR)"
