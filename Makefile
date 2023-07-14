FSFILES=./src/main.fs

.PHONY: build
build: ./out/main.exe

./out/main.exe: fsharp $(FSFILES)
	set -eu ; \
	. ./env.sh ; \
	mkdir -p ./out ; \
	command mono $${FSC} -o:"./out/main.exe" $(FSFILES)

.PHONY: fsharp
fsharp: fsharp-10_2_3

.PHONY: fsharp-10_2_3
fsharp-10_2_3: fsharp-10_2_3-void

.PHONY: fsharp-10_2_3-void
fsharp-10_2_3-void:
	[ -e "./fsharp-10.2.3-void/usr/lib/mono/fsharp/fsc.exe" ] || rm -f ./env.sh
	set -eu ; \
	[ -e "./env.sh" ] || { \
	    [ -e "./fsharp-10.2.3-void/usr/lib/mono/fsharp/fsc.exe" ] || { \
	        ! [ -d "./fsharp-10.2.3-void" ] || rm -rf "./fsharp-10.2.3-void" ; \
	        mkdir -p "./fsharp-10.2.3-void" ; \
	        curl -L "https://alpha.de.repo.voidlinux.org/current/fsharp-10.2.3_1.x86_64.xbps" | \
	            tar xf - --zstd -C "./fsharp-10.2.3-void" ; \
	    } ; \
	    [ -e "./fsharp-10.2.3-void/usr/lib/mono/fsharp/fsc.exe" ] ; \
	    printf 'FSC="%s"\n' "./fsharp-10.2.3-void/usr/lib/mono/fsharp/fsc.exe" >./env.sh; \
	}
