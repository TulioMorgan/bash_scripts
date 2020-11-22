# idsSameCluster.py

#PT-BR
# Script para ser usado na pipeline de criação de HMM das classes de transposons.
# Recupera os IDs de sequencias de cada cluster obtido apos analise BLASTn/MCL (main script: blast_mcl_sequences.sh).
# Clusters com mais de 2 ou mais sequencias são reportados
# Clusters com 1 sequencia cada são unidos. Nao posso descartar essas sequencias da analise. Esse cluster vai ser chamado de "cluster_X"

# Esses IDs (output) vao ser reportados em uma lista, que servira como entrada para o script extraiSeqFastaIDs_Parallel.py

#EN:
# Script to be used in the pipeline for HMM creation/usage for transposons identifcation.
# Retrieves the sequence IDs for each cluster obtained after BLASTn/MCL analysis (see the main blast_mcl_sequences.sh).
# Clusters with 2 more sequences are reported
# Clusters with 1 sequence each are joined. These cannot be discarted from the analysis. This cluster will be called "cluster_X"

# The IDs (output) will be reported in a list, which will serve as input to the script extractSeqFastaIDs_Parallel.py


usage = "\n		idsSameCluster.py\n\
		Script para ser usado na pipeline de criação de HMM das classes de transposons. Recupera os IDs de sequencias de cada cluster obtido apos analise BLASTn/MCL.\nClusters com mais de 2 ou mais sequencias são reportados. Clusters com 1 sequencia cada são unidos. Nao posso descartar essas sequencias da analise. Esse cluster vai ser chamado de \"cluster_X\"\n\n\
		*** Argumentos obrigatórios\n\
		--input <arquivo> (arquivo de saido do MCL 'mclOutput' com clusters de sequencias, um cluster por linha)\n\
		--output <str> (nome do arquivo de saida)\n\n"

import sys

def retrieveIDs(mclOutput):

	cluster_id = 0
	cluster_geral = [] # vai conter sequencias de clusters que continham apens 1 sequencia.
	for linha in mclOutput:
		linha = linha.rstrip()
		linhaSplit = linha.split('\t') # os ids no cluster (linha) sao separados por tabulacao.
		
		if len(linhaSplit) >= 2:
			cluster_report = '\n'.join(linhaSplit)
			file = open(nomeOutput+'_cluster_'+str(cluster_id), 'w')
			file.writelines(cluster_report)
			file.close()
			cluster_id += 1
		
		elif len(linhaSplit) == 1:
			cluster_geral.append(''.join(linhaSplit))

	# somente imprimir o cluster X se houver sequencias para esse cluster
	if cluster_geral != []:
		cluster_geral = '\n'.join(cluster_geral)
		file = open(nomeOutput+'_cluster_X', 'w')
		file.writelines(cluster_geral)
		file.close()


if __name__ == '__main__': # utilizar o script de forma independente (sem ser como modulo de outro).

	if len(sys.argv) < 5:
		print(usage)
		exit()
	else:
		if '--input' in sys.argv:
			argINPUT = sys.argv.index('--input')+1
			file = open(sys.argv[argINPUT],'r')
			fileInput = file.readlines()
			file.close()
		else:
			print(usage)
			exit()

		if '--output' in sys.argv:
			argOUT = sys.argv.index('--output')+1
			nomeOutput = str(sys.argv[argOUT])
		else:
			print(usage)
			exit()

		# Nao precisa salvar em variavel, pois a funcao salva os dados em um arquivo de saida.
		retrieveIDs(fileInput)


