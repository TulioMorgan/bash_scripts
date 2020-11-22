#!/bin/bash

declare -A fruits # declarar um array ASSOCIATIVO

fruits=(["morango"]="vermelho" ["abacate"]="verde")

# usamos metodos/funcoes da mesma forma que para arrays.

fruits['key']='value' # para criar um novo elemento (chave:valor)
${fruits[@]} # visualizar todos os VALORES do objeto.
${!fruits[@]} # visualizar todas as CHAVES do objeto.

for fruta in ${!fruits[@]}; do
	echo "A cor da fruta ""$fruta"" eh ""${fruits[$fruta]}"
done
