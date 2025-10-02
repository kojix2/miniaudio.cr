MINIAUDIO_IMPL = miniaudio_impl.c
OUT = libminiaudio.a

CC ?= cc
CFLAGS ?= -O2 -fPIC -I.

all: $(OUT)

$(OUT): $(MINIAUDIO_IMPL)
	$(CC) $(CFLAGS) -c $(MINIAUDIO_IMPL) -o miniaudio_impl.o
	ar rcs $(OUT) miniaudio_impl.o

clean:
	rm -f miniaudio_impl.o $(OUT)

.PHONY: all clean
