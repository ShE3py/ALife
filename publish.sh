#!/bin/bash

set -e
cd  $(dirname -- $(readlink --canonicalize-existing -- $BASH_SOURCE))

make -B wasm

cp src/common/passthrough.vsh src/www/common-passthrough.vsh

wasm2wat physarum --inline-exports --generate-names -o src/www/physarum.wat
mv physarum src/www/physarum.wasm

cp src/physarum/config.c src/www/physarum-config.c
cp src/physarum/simulator.fsh src/www/physarum-simulator.fsh
cp src/physarum/renderer.fsh src/www/physarum-renderer.fsh

# git subtree push --prefix src/www/ origin gh-pages
