#!/bin/bash

# substituir caracteres em strings
string='foo bar qux'
one="${string/ /.}"     # sets one to 'foo.bar qux' # substitui apenas o primeiro espaço por ponto
all="${string// /.}"    # sets all to 'foo.bar.qux' # substitui todos os espaços por ponto

# Encontrar regex em string
# segue ideia semelhante a regex de Python, com metacaracteres e tudo (^$+)
padrao=[0-9a-zA-Z_]

if [[ $digit =~ $padrao ]]; then 
    echo "pattern found in $digit"
else
    echo "oops! Not pattern found..."
fi

# substrings sem gerar lista
string=foo_bar_qux
substring=${string##*_} # pega o ultimo elemento da lista gerada pela quebra da string no delimitador '_'
nome=meu_arquivo.txt
sem_extensao=${nome%.txt} # pega tudo ANTES de '.txt' 
nome=meu_arquivo.texto_ou_outra-extensao-qualquer # pega tudo antes do separador '.'
sem_extensao=${nome%.*}