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

wasm2wat gray-scott --inline-exports --generate-names -o generated/gray-scott.wat
mv gray-scott generated/gray-scott.wasm
cp src/gray-scott/config.c generated/gray-scott-config.c
cp src/gray-scott/simulator.fsh generated/gray-scott-simulator.fsh
cp src/gray-scott/renderer.fsh generated/gray-scott-renderer.fsh

cd generated/
tree -P physarum.html -P gray-scott.html -T ALife -H . -o index.html
cd ..

# git subtree push --prefix generated/ origin gh-pages

