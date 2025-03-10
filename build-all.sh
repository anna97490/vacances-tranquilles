#!/bin/bash

function build_dir()  # $1 is the dir to get it
{
    cd $1
    bash build.sh
    cd ..
}

echo "** Building all"

#build_dir "front-end"
build_dir "back-end"

echo "** Done all"