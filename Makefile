VERSION=2.24

build: unpack
	cd util-linux-$(VERSION) ; \
	./configure --without-ncurses ; \
	make LDFLAGS=-all-static nsenter ; \
	cp nsenter ../

unpack: util-linux-$(VERSION).tar.gz
	tar xzf util-linux-$(VERSION).tar.gz

install: build
	mkdir -p $(DESTDIR)/usr/bin
	cp nsenter $(DESTDIR)/usr/bin/nsenter
	cp docker-enter $(DESTDIR)/usr/bin/docker-enter
	chmod 755 $(DESTDIR)/usr/bin/nsenter
	chmod 755 $(DESTDIR)/usr/bin/docker-enter

clean:
	rm -rf nsenter
	rm -rf util-linux-$(VERSION)

%:
	wget https://www.kernel.org/pub/linux/utils/util-linux/v$(VERSION)/$@

dsc: util-linux-$(VERSION).tar.gz
	dpkg-source -b .
