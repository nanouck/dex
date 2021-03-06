NAME = dex
PREFIX = /usr/local
DOCPREFIX = $(PREFIX)/share/doc/$(NAME)
MANPREFIX = $(PREFIX)/man
VERSION = $(shell git tag | tail -n 1)
TAG = dex-$(VERSION)

build:

install: dex dex.1 README LICENSE
	@echo installing executable file to $(DESTDIR)$(PREFIX)/bin
	@mkdir -p $(DESTDIR)$(PREFIX)/bin
	@install -m 0755 $< $(DESTDIR)$(PREFIX)/bin/
	@echo installing docs to $(DESTDIR)$(DOCPREFIX)
	@mkdir -p $(DESTDIR)$(DOCPREFIX)
	@install -m 0644 -t $(DESTDIR)$(DOCPREFIX)/ README LICENSE
	@echo installing manual page to $(DESTDIR)$(MANPREFIX)/man1
	@mkdir -p $(DESTDIR)$(MANPREFIX)/man1
	@install -m 0644 -t $(DESTDIR)$(MANPREFIX)/man1 dex.1
	@sed -i -e "s/VERSION/$(VERSION)/g" $(DESTDIR)$(MANPREFIX)/man1/dex.1

tgz: source

source: dex dex.1 README LICENSE Makefile
	@echo "Creating source package: $(TAG).tar.gz"
	@mkdir $(TAG)
	@cp -t $(TAG) $+
	@tar czf $(TAG).tar.gz $(TAG)
	@rm -rf $(TAG)

clean:
	@rm $(TAG).tar.gz

.PHONY: build install tgz source
