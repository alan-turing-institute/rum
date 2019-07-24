## Make a distribution of rum suitable for homebrew

.PHONY : all clean

all : dist/bin/rum

dist/bin/rum : rum
	raco distribute dist rum

rum : rum.rkt rum-config.rkt event.rkt schedule.rkt azure.rkt graph.rkt meeting.rkt oauth-deviceflow.rkt info.rkt parse-command-line.rkt
	raco exe rum.rkt

clean :
	rm -f rum
	rm -fr dist/bin
	rm -fr dist/lib



