CC = clang
CFLAGS = -Wall -Wextra -std=gnu99
LDFLAGS = -Llib/linux -lraylib -lGL -lm -lpthread -ldl -lrt -lX11

SRCDIR = src
TARGETDIR = target
BINDIR = bin
SRCS = $(wildcard $(SRCDIR)/*.c)
OBJS = $(patsubst $(SRCDIR)/%.c,$(TARGETDIR)/%.o,$(SRCS))
BIN = test

DEBUG ?= 0
ifeq ($(DEBUG), 1)
    CFLAGS += -g -O0
else
    CFLAGS += -O3
endif

.PHONY: all clean

# Default
all: run

run: $(BIN)
	./bin/$^

$(BIN): $(OBJS)
	@mkdir -p $(BINDIR)
	$(CC) $(CFLAGS) $^ $(LDFLAGS) -v -o $(BINDIR)/$@

$(TARGETDIR)/%.o: $(SRCDIR)/%.c
	@mkdir -p $(TARGETDIR)
	$(CC) $(CFLAGS)  -c $^ -o $@

clean:
	rm -fr $(TARGETDIR)/* $(BINDIR)/*

