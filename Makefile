## Make a distribution of rum suitable for homebrew

VERSION := $(shell git describe --abbrev=0)

.PHONY : all clean

all : dist/rum-$(VERSION).tar.gz

dist/rum-$(VERSION).tar.gz : rum
	raco distribute dist/rum rum
	cd dist && tar -czvf rum-$(VERSION).tar.gz rum

rum : rum.rkt rum-config.rkt event.rkt schedule.rkt azure.rkt graph.rkt meeting.rkt oauth-deviceflow.rkt
	raco exe rum.rkt

clean :
	rm -f rum
	rm -fr dist/rum


