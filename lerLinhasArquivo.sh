#!/bin/bash

# ler linha a linha do arquivo $file.
file="arquivo.txt"
while read line; do
	printf "$line\n" # imprime cada linha do arquivo e adiciona quebra de linha.
done < "$file"
