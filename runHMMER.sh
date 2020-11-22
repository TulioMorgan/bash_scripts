#!/bin/bash

#PT-BR:
# script para criar HMMs (hmmbuild/hmmpress) e realizar alinhamentos contra um genoma (nhmmer)
# deve-se fornecer um arquivo com nomes de arquivos de alinhamento multiplo em formato fasta.
# Eh necessario adicionar o executavel do hmmer a variavel PATH.

#EN:
# script to create HMMs (hmmbuild / hmmpress) and perform alignments against a genome (nhmmer)
# a file with multiple sequence alignment in fasta format must be provided.
# It is necessary to add the hmmer executable to the PATH variable.

export PATH=$PATH:/home/tuliomorgan/doutorado/programas/hmmer-3.2.1/bin

# testar se a instabalacao do hmmer esta disponivel.
executable_path=$(hmmbuild -h)
if [ -z $executable_path ]; then # -z STRING 	The lengh of STRING is zero (ie it is empty).
	echo "ERRO: Nao foi possivel executar o comando 'hmmbuild'. Instale hmmer/3.2.1 ou superior e insira o caminho completo do executavel na variavel de ambiente PATH."
	exit
fi

# testar se recebeu um arquivo de lista de arquivos.
if [ "$1" ]; then
	echo "Arquivo de lista de arquivos fornecido: $1"
else
	echo "Erro: Forneca um arquivo contendo uma lista de arquivos de alinhamentos multiplos de sequencias. Ex.: lista_arquivos.txt"
	exit
fi

# testar se recebeu um arquivo de genoma.
if [ "$2" ]; then
	echo "Arquivo de genoma fornecido: $2"
else
	echo "Erro: Forneca um arquivo de genoma. Ex.: genoma.fna"
	exit
fi

# abrir arquivo com nomes dos arquivos para serem analisados pelo HMMER.
nomes=$(cat $1) # lista_arquivos.txt contem os nomes dos arquivos de alinhamentos multiplo fasta para serem analisados.
for file in $nomes; do
	outfile=$file".hmm";
	hmmbuild --dna --cpu 3 $outfile $file
	hmmpress -f $outfile
done

for file in $nomes; do
	outfile=$file".hmm_scanned"
	echo $outfile
	nhmmer --tblout $file".hmm_scanned" --cpu 3 --noali $file".hmm" $2
done