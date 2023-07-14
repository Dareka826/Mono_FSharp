FSFILES=./src/main.fs

.PHONY: build
build: fsharp ./out/main.exe

./out/main.exe: $(FSFILES)
	mkdir -p ./out
	. ./env.sh; \
	mono "$${FSC}" -o:"./out/main.exe" $(FSFILES)

.PHONY: fsharp
fsharp: fsharp-10_2_3

.PHONY: fsharp-10_2_3
fsharp-10_2_3: fsharp-10_2_3-void

.PHONY: fsharp-10_2_3-void
fsharp-10_2_3-void:
	@set -eu; \
	FS_DIR="./fsharp-10.2.3-void"; \
	FSC_PATH="$${FS_DIR}/usr/lib/mono/fsharp/fsc.exe"; \
	\
	[ -e "$${FSC_PATH}" ] || { \
	    rm -rf "$${FS_DIR}"; \
	    rm -f ./env.sh; \
	    mkdir -p "./fsharp-10.2.3-void"; \
	    curl -L "https://alpha.de.repo.voidlinux.org/current/fsharp-10.2.3_1.x86_64.xbps" | \
	        tar xf - --zstd -C "./fsharp-10.2.3-void"; \
	    [ -e "./fsharp-10.2.3-void/usr/lib/mono/fsharp/fsc.exe" ] || { \
	        printf "Failed to download fsc.exe\n" >&2; \
	        exit 1; \
	    }; \
	}; \
	\
	[ -e ./env.sh ] || \
	    printf 'FSC="%s"\n' "$${FSC_PATH}" >./env.sh
