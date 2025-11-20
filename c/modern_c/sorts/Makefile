CC = gcc
CFLAGS = -Wall -Wextra -std=c23 -pedantic
DFLAGS =
LDFLAGS =

RELEASE ?= 0
ifeq ($(RELEASE), 0)
    CFLAGS += -g -O0 -fsanitize=address -fno-omit-frame-pointer
		DFLAGS += -DDEBUG -D_DEBUG
else
    CFLAGS += -O3
endif

# Default
bin/main: objects/main.o
	@mkdir -p bin
	$(CC) $(CFLAGS) $(LDFLAGS) $(DFLAGS) $^ -o $@

objects/main.o: src/main.c
	@mkdir -p objects
	$(CC) $(CFLAGS) $(LDFLAGS) $(DFLAGS) -c $^ -o $@

compile_flags.txt:
	@echo $(CFLAGS) | tr ' ' '\n' > compile_flags.txt
	@echo $(LDFLAGS) | tr ' ' '\n' >> compile_flags.txt
	@echo $(DFLAGS) | tr ' ' '\n' >> compile_flags.txt

run: bin/main
	./fuzzer.sh

build: bin/main

all: compile_flags.txt run

clean:
	rm -fr bin objects compile_flags.txt

.PHONY: all clean compile_flags.txt build
