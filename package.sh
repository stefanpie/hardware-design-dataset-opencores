#!/usr/bin/env sh

if [ -f designs.zip ]; then
    rm designs.zip
fi

if [ -f designs.tar.gz ]; then
    rm designs.tar.gz
fi

zip -9 -r designs.zip designs
tar -czvf designs.tar.gz designs