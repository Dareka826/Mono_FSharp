FSFILES=./src/main.fs

.PHONY: build
build: main.exe

main.exe: fsharp $(FSFILES)
	set -eu ; \
	. ./env.sh ; \
	mkdir -p ./out ; \
	command mono $${FSC} -o:"./out/main.exe" $(FSFILES)

.PHONY: fsharp
fsharp: fsharp-10_2_3

.PHONY: fsharp-10_2_3
fsharp-10_2_3: fsharp-10_2_3-void

.PHONY: fsharp-10_2_3-src
fsharp-10_2_3-src:
	set -eu ; [ -d "./fsharp-10.2.3" ] || { \
	    curl -L "https://github.com/fsharp/fsharp/archive/refs/tags/10.2.3.tar.gz" | \
	    tar xzf - ; \
	}
	set -eu ; [ -e "./env.sh" ] || { \
	    cd "./fsharp-10.2.3" ; \
	    make ; \
	    cd .. ; \
	    printf 'FSC="%s"\n' "./fsharp-10.2.3/Release/net40/bin/fsc.exe" >env.sh; \
	}

.PHONY: fsharp-10_2_3-void
fsharp-10_2_3-void:
	set -eu ; [ -d "./fsharp-10.2.3-void" ] || { \
	    mkdir -p "./fsharp-10.2.3-void" ; \
	    curl -L "https://alpha.de.repo.voidlinux.org/current/fsharp-10.2.3_1.x86_64.xbps" | \
	    tar xf - --zstd -C "./fsharp-10.2.3-void" ; \
	    rm -f ./env.sh ; \
	}
	set -eu ; [ -e "./env.sh" ] || { \
	    printf 'FSC="%s"\n' "./fsharp-10.2.3-void/usr/lib/mono/fsharp/fsc.exe" >env.sh; \
	}
