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
# percorre a variavel $nomes, que contem um ID por linha.
for id in $nomes; do
	if [ $i -le $quebra ]; then # testa se 'i' ainda eh menor ou igual ao numero de IDs que devem estar em um mesmo arquivo
		echo $id >> "splited_ids_"$quebra
	fi
	i=$(($i+1)) # soma unidade a variavel 'i'
	
	if [ $i -eq $quebra ]; then # testa se 'i' eh igual ao numero de IDs que devem estar em um mesmo arquivo
		quebra=$(($quebra+5000)) # se verdadeiro, soma 5000 a variavel quebra, de modo que o ID 5001 (i=5001) seja salvo em outro arquivo (nomeado "splited_ids_"$quebra)
	fi
done
