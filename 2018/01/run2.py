#!/usr/bin/env python3

import sys

lines = open('input', 'r').readlines()
nums = [int(x) for x in lines]

visited = {0: True}
current = 0

while True:
    for n in nums:
        current += n
        if current in visited:
            print(current)
            sys.exit(0)
        visited[current] = True
