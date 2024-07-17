#!/bin/bash

set -e
cd  $(dirname -- $(readlink --canonicalize-existing -- $BASH_SOURCE))

make -B wasm

cp src/www/* generated/
cp src/common/passthrough.vsh generated/common-passthrough.vsh

wasm2wat physarum --inline-exports --generate-names -o generated/physarum.wat
mv physarum generated/physarum.wasm

cp src/physarum/config.c generated/physarum-config.c
cp src/physarum/simulator.fsh generated/physarum-simulator.fsh
cp src/physarum/renderer.fsh generated/physarum-renderer.fsh

cd generated/
tree -P physarum.html -T ALife -H . -o index.html
cd ..

git subtree push --prefix generated/ origin gh-pages
