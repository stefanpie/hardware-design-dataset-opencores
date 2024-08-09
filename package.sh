#!/usr/bin/env sh

if [ -f designs.zip ]; then
    rm designs.zip
fi

zip -9 -r designs.zip designs
tar -czvf designs.tar.gz designs