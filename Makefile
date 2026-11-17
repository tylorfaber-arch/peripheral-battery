PREFIX ?= /usr
DESTDIR ?=
PLASMOID = $(DESTDIR)$(PREFIX)/share/plasma/plasmoids/peripheral-battery

install:
	install -Dm755 peripheral-battery $(DESTDIR)$(PREFIX)/bin/peripheral-battery
	install -Dm644 plasmoid/metadata.json $(PLASMOID)/metadata.json
	install -Dm644 -t $(PLASMOID)/contents/ui plasmoid/contents/ui/*.qml
	install -Dm644 -t $(PLASMOID)/contents/config plasmoid/contents/config/*
	install -Dm644 -t $(DESTDIR)$(PREFIX)/lib/systemd/user systemd/peripheral-battery-alert.*
	install -Dm644 LICENSE $(DESTDIR)$(PREFIX)/share/licenses/peripheral-battery/LICENSE

.PHONY: install
