package main

import (
	"bufio"
	"fmt"
	"log"
	"os"
)

func main() {
	f, err := os.Open("input")
	if err != nil {
		log.Fatal(err)
	}
	scanner := bufio.NewScanner(f)
	for scanner.Scan() {
		text := scanner.Text()
		increment(counts([]byte(text)))
	}
	fmt.Println(count2 * count3)
}

func counts(s []byte) (twice bool, thrice bool) {
	counts := make([]int, 26)
	for _, b := range s {
		counts[b-'a']++
	}

	for _, c := range counts {
		if c == 2 {
			twice = true
		}
		if c == 3 {
			thrice = true
		}
	}

	return
}

var count2, count3 = 0, 0

func increment(twice, thrice bool) {
	if twice {
		count2++
	}
	if thrice {
		count3++
	}
}
