#!/bin/bash -e

gcc main.c
./a.out 1 < input
./a.out 2 < input
