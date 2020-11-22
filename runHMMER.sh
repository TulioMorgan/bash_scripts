#!/bin/bash

#PT-BR:
# script para criar HMMs (hmmbuild/hmmpress) e realizar alinhamentos contra um genoma (nhmmer)
# deve-se fornecer um arquivo com nomes de arquivos de alinhamento multiplo em formato fasta.
# Eh necessario adicionar o executavel do hmmer a variavel PATH.

#EN:
# script to create HMMs (hmmbuild / hmmpress) and perform alignments against a genome (nhmmer)
# a file with multiple sequence alignment in fasta format must be provided.
# It is necessary to add the hmmer executable to the PATH variable.

export PATH=$PATH:/home/user/hmmer-3.2.1/bin # exporta executavel para variavel de ambiente $PATH

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

# abrir arquivo com nomes dos arquivos para serem analisados pelo HMMER (hmmbuild/hmmpress).
nomes=$(cat $1) # lista_arquivos.txt contem os nomes dos arquivos de alinhamentos multiplo fasta para serem analisados.
for file in $nomes; do
	outfile=$file".hmm"; # nome do arquivo de saida contendo os HMMs
	hmmbuild --dna --cpu 3 $outfile $file # executa o hmmbuild
	hmmpress -f $outfile # executa o hmmpress
done

# abrir arquivo com nomes dos arquivos para serem analisados pelo HMMER (nhmmer).
for file in $nomes; do
	outfile=$file".hmm_scanned" # nome do arquivo de saida contendo os alinhamentos contra o HMMs criados anteriormente.
	nhmmer --tblout $file".hmm_scanned" --cpu 3 --noali $file".hmm" $2 # executa o nhmmer
done
