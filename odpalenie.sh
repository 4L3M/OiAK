#!/bin/bash
gcc -nostartfiles -no-pie -g -o program program.s -lc
./program