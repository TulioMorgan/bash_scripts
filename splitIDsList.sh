#!bin/bash

#PT-BR:
# divide uma grande lista de IDs em listas menores. Cada ID deve estar em uma linha.
# a saida consiste em multiplos arquivos com "n" IDs em cada um.
# esta configurado para ter no maximo 5000 IDs por arquivo (variavel `quebra`).

#EN:
# divides a large list of IDs into smaller ones. Each ID must be on a line.
# the output consists of multiple files with "n" IDs in each.
# is configured to have a maximum of 5000 IDs per file (variable `quebra`).

nomes=$(cat arquivos_lista_IDs.txt)
i=0
quebra=5000
for id in $nomes; do
	
	if [ $i -le $quebra ]; then
		echo $id >> "splited_ids_"$quebra
	fi
	i=$(($i+1))
	
	if [ $i -eq $quebra ]; then
		quebra=$(($quebra+5000))
	fi
done