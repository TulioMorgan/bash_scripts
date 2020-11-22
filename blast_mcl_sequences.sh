#!/bin/bash

#PT-BR:
# script para obter multiplos arquivos fasta de nucleotideos para construcao de HMMs (HMMER).
# deve ter NCBI-BLAST, MCL and python3 instalados no sistema.
# 1: alinhamentos de sequencia com BLASTn
# 2: selecao das colunas da saida do BLAST com 'awk' e execucao do MCL para clusterizacao
# 3: recupera os IDs das sequencias que compoem cada cluster (idsSameCluster.py).
# 4: recupera sequencias fasta de cada cluster fazendo uso da lista de IDs anteriormente obtida (extraiSeqFastaIDs.py).

#EN:
# script to obtain multiple nucleotide fasta files for building HMMs (HMMER).
# must have NCBI-BLAST, MCL and python3 installed.
# 1: sequence alignments with BLASTn
# 2: selection of BLAST output columns with 'awk' and execution of the MCL for clustering
# 3: retrieve the IDs of the sequences that comprise each cluster (idsSameCluster.py).
# 4: retrieve fasta sequences from each cluster using the previously obtained list of IDs (extractSeqFastaIDs.py).

nomes=$(cat lista_arquivos_blastn-all-vs-all.txt) # lista de nomes de arquivos fasta para serem analisados.

for file in $nomes; do
	
	formatdb -p F -i "$file" # criacao do banco de dados para analise com BLAST. Pode ser necessario usar makedb ao inves de formatdb
	nomeOutput="blastn_""$file""_vs_""$file"".txt"
	
	# executacao do BLAST
	blastn -query "$file" -db "$file" -outfmt "6 qseqid qstart qend qlen qcovs sseqid sstart send slen length pident evalue stitle bitscore" -evalue 1e-2 -out "$nomeOutput" -num_threads 10 -max_target_seqs 500 -max_hsps 1
	
	# elimina arquivos nao mais necessarios (arquivos de banco de dados do BLAST)
	rm "$file"".nsq" "$file"".nin" "$file"".nhr" formatdb.log

	# gerar o arquivo de entrada do MCL com base na saida do BLASTn
	awk -F'\t' '{$4=$4*$9; $14=$14/$4; print($1"\t"$6"\t"$14)}' "$nomeOutput" > "mclInput_""$file" 
	
	# elimina arquivo de saida do BLAST.
	rm blastn_*.txt
	
	# executar o MCL
	mcl "mclInput_""$file" --abc -I 1.2 -te 10 -o "mclOutput_""$file"
	
	# chamar o script em python para criar diferentes arquivos de IDs para serem extraidos pelo extraiSeqIDsFasta.py. Nao tem problema --output ser o $file pois cria um sufixo "_cluster_"<int>
	python3 idsSameCluster.py --input "mclOutput_""$file" --output "$file"
	
	rm mclInput* mclOutput*

	# criar uma lista de arquivos de IDs para fazer um loop para extrair as sequencias fasta.
	ls *_cluster_* > lista_arquivos_Ids_extrairSeqFasta.txt
	
	mkdir fasta_classes_clusters # cria diretorio para armazenar os arquivos fasta de sequencias de cada cluster
	all_arquivos=$(cat lista_arquivos_Ids_extrairSeqFasta.txt) # arquivo contendo nomes de arquivos que contem os IDs de cada cluster.
	for arquivo_ids in $all_arquivos; do
		numero=${arquivo_ids##*_} # pega o ultimo elemento (numero do cluster) de uma string separada por '_'. Para criar o nome de saida.
		nome=${file%.*} # pega tudo antes do delimitador ponto '., nao importando o que vem apos o ponto (nao importa a extensão do arquivo).
		python3 extraiSeqFastaIDs.py "$arquivo_ids" "$file" # extrair sequencias fasta de um arquivo multifasta com base na lista de IDs.
		mv sequencias_extraidas.fasta fasta_classes_clusters/"$nome""_cluster""$numero"".fasta"
	done
	rm *_cluster_*
	rm lista_arquivos_Ids_extrairSeqFasta.txt
done
