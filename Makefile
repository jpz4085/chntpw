#
# Makefile for the Offline NT Password Editor
#
# Available targets:
# make              compile binaries
# make install      install compiled programs and documentation
# make uninstall    remove installed programs and documentation
# make clean        remove binaries
# make distclean    remove binaries and associated folders (bin/obj)
#
# Contributers: jpz4085, Mina Her, and Petter Nordahl-Hagen

# Installation paths.
PREFIX ?= /opt/local
BINDIR = $(PREFIX)/bin
MANDIR = $(PREFIX)/man/man8
DOCDIR = $(PREFIX)/share/doc/chntpw

# OpenSSL include and library paths.
OSSLINC = $(PREFIX)/include/openssl-1.1
OSSLLIB = $(PREFIX)/lib/openssl-1.1

CC=gcc

# Resource folders for binaries, documentation, and source files.
BINS = bin
DOCS = doc
MANS = man
OBJS = obj
SRCS = src

CFLAGS= -DDOCRYPTO -g -I. -I$(OSSLINC) -Wall

LIBS=-L$(OSSLLIB) $(OSSLLIB)/libcrypto.a $(PREFIX)/lib/libz.a

PACKAGES = chntpw cpnt reged samusrgrp sampasswd samunlock
BUILDPKGS = $(addprefix $(BINS)/, $(PACKAGES))
BIN_FILES = $(addprefix $(BINDIR)/, $(PACKAGES))
DOC_FILES = $(foreach FILE, $(wildcard $(DOCS)/*.txt), $(subst $(DOCS),$(DOCDIR),$(dir $(FILE)))$(notdir $(FILE)))
MAN_FILES = $(foreach FILE, $(wildcard $(MANS)/*.8), $(subst $(MANS),$(MANDIR),$(dir $(FILE)))$(notdir $(FILE)))
GZIP_FILES = $(foreach FILE, $(wildcard $(MANS)/*.8), $(subst $(MANS),$(MANDIR),$(dir $(FILE)))$(subst .8,.8.gz,$(notdir $(FILE))))

all: $(BUILDPKGS)

install: $(BUILDPKGS) $(BIN_FILES) $(DOC_FILES) $(MAN_FILES)

uninstall:
	$(RM) $(BIN_FILES)
	$(RM) $(GZIP_FILES)
	$(RM) -r $(DOCDIR)

$(BINDIR)/%: $(BINDIR)
	install -m 755 $(BINS)/$(*F) $(@D)

$(DOCDIR)/%: $(DOCDIR)
	install -m 644 $(DOCS)/$(*F) $(@D)

$(MANDIR)/%: $(MANDIR)
	install -m 644 $(MANS)/$(*F) $(@D)
	gzip -nf $@

$(BINDIR) $(DOCDIR) $(MANDIR):
	install -d $@

$(BINS) $(OBJS):
	mkdir $@

$(BINS)/chntpw: $(addprefix $(OBJS)/, chntpw.o ntreg.o edlib.o libsam.o)
	$(CC) $(CFLAGS) -o $@ $^ $(LIBS)

$(BINS)/cpnt: $(OBJS)/cpnt.o
	$(CC) $(CFLAGS) -o $@ $< $(LIBS)

$(BINS)/reged: $(addprefix $(OBJS)/,  reged.o ntreg.o edlib.o)
	$(CC) $(CFLAGS) -o $@ $^

$(BINS)/samusrgrp: $(addprefix $(OBJS)/, samusrgrp.o ntreg.o libsam.o)
	$(CC) $(CFLAGS) -o $@ $^

$(BINS)/sampasswd: $(addprefix $(OBJS)/, sampasswd.o ntreg.o libsam.o)
	$(CC) $(CFLAGS) -o $@ $^

$(BINS)/samunlock: $(addprefix $(OBJS)/, samunlock.o ntreg.o libsam.o)
	$(CC) $(CFLAGS) -o $@ $^

$(OBJS)/%.o: $(SRCS)/%.c | $(OBJS) $(BINS)
	$(CC) -c $(CFLAGS) -o $@ $<

clean:
	rm -f $(BINS)/* $(OBJS)/* *~

distclean: clean
	rm -d $(BINS) $(OBJS)
