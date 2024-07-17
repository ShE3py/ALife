#!/bin/bash

# Uninitialized statics
grep --color -r . -e 'static [^(=]*;'

