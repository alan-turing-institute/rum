## Make a distribution of rum suitable for homebrew

.PHONY : all clean

all : dist/rum/bin/rum

dist/rum/bin/rum : rum
	raco distribute dist/rum rum

rum : rum.rkt rum-config.rkt event.rkt schedule.rkt azure.rkt graph.rkt meeting.rkt oauth-deviceflow.rkt
	raco exe rum.rkt

clean :
	rm rum
	rum -r dist/rum

