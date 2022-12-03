package main

import (
	"bufio"
	"fmt"
	"log"
	"os"
)

func main() {
	solve1()
	solve2()
}

func solve1() {
	f, err := os.Open("input")
	if err != nil {
		log.Fatal(err)
	}
	defer f.Close()

	scanner := bufio.NewScanner(f)
	sumOfPriorities := 0
	for scanner.Scan() {
		line := scanner.Bytes()

		firstItems := map[byte]bool{}
		secondItems := map[byte]bool{}

		for _, c := range line[:len(line)/2] {
			firstItems[c] = true
		}
		for _, c := range line[len(line)/2:] {
			secondItems[c] = true
		}
		for c, _ := range firstItems {
			if _, ok := secondItems[c]; ok {
				if c >= 'a' && c <= 'z' {
					sumOfPriorities += int(c-'a') + 1
				} else if c >= 'A' && c <= 'Z' {
					sumOfPriorities += int(c-'A') + 27
				}
			}
		}
	}
	fmt.Println(sumOfPriorities)
}

func solve2() {
	f, err := os.Open("input")
	if err != nil {
		log.Fatal(err)
	}
	defer f.Close()

	scanner := bufio.NewScanner(f)
	sumOfPriorities := 0
	for scanner.Scan() {
		items1 := map[byte]bool{}
		items2 := map[byte]bool{}
		items3 := map[byte]bool{}

		var line []byte
		// scanner.Bytes() doesn't allocate return value
		// so I had to use it before calling the next scanner.Scan()
		// using scanner.Text() would have been no problem
		// since it allocates return values
		line = scanner.Bytes()
		for _, c := range line {
			items1[c] = true
		}

		scanner.Scan()
		line = scanner.Bytes()
		for _, c := range line {
			items2[c] = true
		}

		scanner.Scan()
		line = scanner.Bytes()
		for _, c := range line {
			items3[c] = true
		}

		for c, _ := range items1 {
			_, ok2 := items2[c]
			_, ok3 := items3[c]
			if ok2 && ok3 {
				if c >= 'a' && c <= 'z' {
					sumOfPriorities += int(c-'a') + 1
				} else if c >= 'A' && c <= 'Z' {
					sumOfPriorities += int(c-'A') + 27
				}
			}
		}
	}
	fmt.Println(sumOfPriorities)
}
