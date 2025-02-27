CC = gcc
CFLAGS = -Wall -Wextra -std=c99 -static

TARGETDIR = target
BINDIR = bin
SRCS = $(wildcard *.c)
OBJS = $(patsubst %.c,%.o,$(SRCS))
BIN = search

DEBUG ?= 0
ifeq ($(DEBUG), 1)
    CFLAGS += -g -O0
else
    CFLAGS += -O2
endif

.PHONY: all clean clear

# Default
all: run

run: $(BIN)
	./bin/$(BIN)

$(BIN): $(OBJS)
	@mkdir -p $(BINDIR)
	$(CC) $(CFLAGS) -o $(BINDIR)/$@ $^

$(TARGETDIR)/%.o: $(SRCDIR)/%.c
	@mkdir -p $(TARGETDIR)
	$(CC) $(CFLAGS) -c $^ -o $@

clean:
	rm -fr $(TARGETDIR)/* $(BINDIR)/*

clear: clean
