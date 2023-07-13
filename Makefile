FSFILES= src/main.fs

.PHONY: build
build: main.exe

main.exe: fsharp $(FSFILES)
	set -eu ; \
	. ./env.sh ; \
	mkdir -p out ; \
	$${FSC} -o:"out/main.exe" $(FSFILES)

.PHONY: fsharp
fsharp: fsharp-10_2_3

.PHONY: fsharp-10_2_3
fsharp-10_2_3:
	set -eu ; [ -d "fsharp-10.2.3" ] || { \
	    curl -L "https://github.com/fsharp/fsharp/archive/refs/tags/10.2.3.tar.gz" | \
	    tar xzf - ; \
	}
	set -eu ; [ -e "./env.sh" ] || { \
	    cd "fsharp-10.2.3" ; \
	    make ; \
	    cd .. ; \
	    printf 'FSC="%s"\n' "./fsharp-10.2.3/Release/net40/bin/fsc.exe" >env.sh; \
	}
