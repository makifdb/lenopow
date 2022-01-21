NAME := lenopow
PREFIX ?= /usr/local
BINDIR ?= $(PREFIX)/bin

install:
	install -D -m755 $(NAME) '$(DESTDIR)$(BINDIR)/$(NAME)'

uninstall:
	rm '$(DESTDIR)$(BINDIR)/$(NAME)'
