#!/bin/bash

apk add --no-cache \
	ca-certificates


apk add --virtual .build-deps \
	bash sudo grep vim procps curl git wget \
	mandoc man-pages \
	coreutils grep sed lynx curl make autoconf \
	;
	#wxgtk wxgtk-dev wxgtk3 wxgtk3-dev \
apk add .build-deps \
	make gcc g++ gdb clang nasm pkgconf \
	ncurses ncurses-dev ncurses-static ncurses-terminfo ncurses-terminfo-base \
	musl-dev \
	strace ltrace \
	libxslt libxml2 libxml2-utils \
	openssl libssl1.1 openssh-client openssh-server \
	;


# RUN apk add bpftrace


# RUN apk add cmake bison binutils \
	# llvm bcc bcc-dev bcc-static llvm9 llvm9-dev llvm9-static llvm9-libs \
	# libelf libelf-static elfutils elfutils-dev elfutils-libelf \
	# libbpf libbpf-dev fortify-headers build-base \
	# clang-dev clang-static \
	# cmake cmake-bash-completion \
	# flex flex-libs flex-dev \
	# libc6-compat \
	# zlib-static

## Install bpftrace
	#bcc pkgconf bcc-dev bcc-static \
	#libbpf libgcc \
	#libbpf-dev \
apk add musl ncurses-terminfo-base ncurses-libs readline bash elfutils elfutils-libelf \
	libstdc++ \
	m4 bison binutils libmagic \
	file gmp isl libgomp libatomic mpfr4 mpc1 gcc musl-dev libc-dev g++ make fortify-headers \
	build-base libffi xz-libs libxml2 llvm9-libs clang-libs clang clang-dev clang-static \
	libacl libbz2 expat lz4-libs zstd-libs libarchive ca-certificates nghttp2-libs libcurl \
	rhash-libs libuv cmake cmake-bash-completion elfutils-dev flex flex-libs flex-dev pcre2 \
	git \
	libc6-compat linux-headers llvm9 llvm9-dev llvm9-static gdbm sqlite-libs \
	python3 zlib-dev zlib-static

apk add iperf iperf3
apk add luajit luajit-dev

#git clone https://github.com/iovisor/bpftrace
#mkdir bpftrace/build || ls -ld bpftrace/build
#cd bpftrace/build
#cmake -DCMAKE_BUILD_TYPE=Release ../
#make 
#make install

#wget http://dl-cdn.alpinelinux.org/alpine/edge/testing/x86_64/mokutil-0.4.0-r1.apk
#apk add mokutil-0.4.0-r1.apk


apk add gtk+3.0 gtk+3.0-dev
apk add libelf-static
