AUTHOR_NAME:=Kenneth Aaron
AUTHOR_EMAIL:=flyingrhino@orcon.net.nz
PROJECT_NAME:=nccm
PROJECT_URL:=https://github.com/flyingrhinonz/nccm

ifndef homeinstall
INSTALLBIN:=/usr/bin
INSTALLMAN:=/usr/share/man/man1
INSTALLDOC:=/usr/share/doc/$(PROJECT_NAME)
INSTALLETC:=/etc
else
INSTALLBIN:=$$HOME/.local/bin
INSTALLMAN:=$$HOME/.local/share/man/man1
INSTALLDOC:=$$HOME/.local/share/$(PROJECT_NAME)
INSTALLETC:=$$HOME/.config/$(PROJECT_NAME)
endif

.PHONY: build
build: nccm/nccm.1

.PHONY: clean
clean:
	$(RM) nccm/nccm.1

.PHONY: install
install: build
	install -D -m 755 nccm/nccm -t "$(DESTDIR)$(INSTALLBIN)"
	install -D -m 644 nccm/nccm.yml -t "$(DESTDIR)$(INSTALLETC)"
	install -D -m 644 nccm/nccm.1 -t "$(DESTDIR)$(INSTALLMAN)"
	install -D -m 644 README.md -t "$(DESTDIR)$(INSTALLDOC)"
	install -D -m 644 images/* -t "$(DESTDIR)$(INSTALLDOC)/images"

.PHONY: all
all: build install

nccm/nccm.1:
	argparse-manpage --pyfile ./nccm/nccm --function ParseArgs \
		--author "$(AUTHOR_NAME)" --author-email "$(AUTHOR_EMAIL)" \
		--project-name "$(PROJECT_NAME)" --url "$(PROJECT_URL)" \
		| sed -e 's/argparse-manpage/$(PROJECT_NAME)/g' >nccm/nccm.1

