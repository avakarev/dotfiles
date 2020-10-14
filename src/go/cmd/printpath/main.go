package main

import (
	"fmt"
	"os"
	"strings"
)

func main() {
	for _, path := range strings.Split(os.Getenv("PATH"), ":") {
		fmt.Println(path)
	}
}
