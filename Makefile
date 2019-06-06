## Make a distribution of rum suitable for homebrew

VERSION := $(shell git tag)

.PHONY : all clean

all : dist/rum-$(VERSION).tar.gz

dist/rum-$(VERSION).tar.gz : rum
	raco distribute dist/rum rum
	tar -czvf dist/rum-$(VERSION).tar.gz dist/rum

rum : rum.rkt rum-config.rkt event.rkt schedule.rkt azure.rkt graph.rkt meeting.rkt oauth-deviceflow.rkt
	raco exe rum.rkt

clean :
	rm rum
	rm -r dist/rum


