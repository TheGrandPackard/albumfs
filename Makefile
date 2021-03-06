CC=gcc
NAME=albumfs
PROGRAM=albumfs.c
SOURCES=afspng.c
OBJECTS=$(SOURCES:.c=.o)
MAN=albumfs.1

CFLAGS=-Wall -D_FILE_OFFSET_BITS=8
PKG=`pkg-config fuse --cflags --libs`
LIBS=-lpng -lm -lssl -lcrypto

all: objects $(NAME)
	rm ${OBJECTS}

install:
	cp $(NAME) /usr/bin
	gzip $(MAN)
	cp $(MAN).gz /usr/share/man/man1
	rm -f $(MAN).gz

$(NAME): $(OBJECTS)
	$(CC) $(OBJECTS) $(PROGRAM) $(CFLAGS) $(PKG) $(LIBS) -o $(NAME)

objects: ${OBJECTS}

.c.o:
	$(CC) $(CFLAGS) -c $< -o $@

.PHONY: clean all

clean: clean-objects
	rm -f ${NAME}

clean-objects:
	rm -f ${OBJECTS}
