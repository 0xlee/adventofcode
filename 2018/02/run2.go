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
	lines := []string{}
	for scanner.Scan() {
		lines = append(lines, scanner.Text())
	}

	for i := 0; i < len(lines); i++ {
		for j := i + 1; j < len(lines); j++ {
			diffCount := charDiffers(lines[i], lines[j])
			if diffCount < 2 {
				printCommon(lines[i], lines[j])
			}
		}
	}
}

func charDiffers(a, b string) int {
	differCount := 0
	for i := 0; i < len(a); i++ {
		if a[i] != b[i] {
			differCount++
		}
	}

	return differCount
}

func printCommon(a, b string) {
	for i := 0; i < len(a); i++ {
		if a[i] == b[i] {
			fmt.Printf("%c", a[i])
		}
	}
	fmt.Println()
}
