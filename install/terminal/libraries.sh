#!/bin/bash

sudo dnf install -y \
  @development-tools pkg-config autoconf bison clang rustc pipx \
  openssl-devel readline-devel zlib-devel libyaml-devel readline-devel ncurses-devel libffi-devel gdbm-devel jemalloc \
  vips imagemagick ImageMagick-devel mupdf mupdf-tools \
  redis sqlite sqlite-devel mysql-devel libpq-devel postgresql postgresql-contrib
