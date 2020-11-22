#!bin/bash

#PT-BR:
# Script para executar BLAST com multiplos arquivos fasta.
# deve-se editar o nome do arquivo (lista_nomes_arquivos_fasta.txt) na linha abaixo.

#EN:
# Script to execute BLAST with multiple files (fasta).
# you must edit the name of the file (lista_nomes_arquivos_fasta.txt) in the line below.

nomes=$(cat lista_nomes_arquivos_fasta.txt) # lista de arquivos fasta para serem 'blastados'
mkdir clusters_ganhados_dollop_anotacaoBLASTp/ # cria diretorio para armazenar os resultados
for file in $nomes; do

	nomeOutput=${file##*/}"_blasted" # formata o nome do arquivo de saida. Quebra a string $file em '/' e pega o ultimo elemento (nome do arquivo fasta)
	blastp -query "$file" -db ../phi-base_May2020.fas -outfmt "6 qseqid sseqid qstart qend pident length slen evalue sstart send stitle qcovs" -evalue 1e-5 -num_threads 3 -max_target_seqs 1 -out "$nomeOutput" # executa o BLAST

	if ! [ -s "$nomeOutput" ]; then # testa se o arquivo de saida tem conteudo.
		echo "Arquivo ""$file"" nao gerou output. Deletando..."
		rm "$nomeOutput"
	else
		mv "$nomeOutput" clusters_ganhados_dollop_anotacaoBLASTp/
	fi

done