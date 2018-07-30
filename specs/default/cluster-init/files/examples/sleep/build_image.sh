#!/bin/bash

echo "Run as root or sudo..."

singularity build --writable sleep_x.ubuntu.img Singularity
