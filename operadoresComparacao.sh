#!/bin/bash

#5 == 6	If [ 5 -eq 6 ]
#5 != 6	If [ 5 -ne 6 ]
#5 < 6	If [ 5 -lt 6 ]
#5 <= 6	If [ 5 -le 6 ]
#5 > 6	If [ 5 -gt 6 ]
#5 >= 6	If [ 5 -ge 6 ]

## ATENCAO! Em bash nao existe numero float. Para comparar dois numeros com casa decimal, usar a linguagem 'awk'

numero_1=6.5
numero_2=5.5

awk '{
	if($1 < $2)
		{print $1" eh menor que "$2}
	else if ($1 > $2)
		{print $1" eh maior que "$2}
	else
		{print $1 " eh igual a "$2}
	}' <<< "${numero_1} ${numero_2}"



# Encontrar regex em string
# segue ideia semelhante a regex de Python, com metacaracteres e tudo mais (^$+)
padrao=[0-9a-zA-Z_]

if [[ $digit =~ $padrao ]]; then 
    echo "pattern found in $digit"
else
    echo "oops! Not pattern found..."
fi

#Operator 	Description
! EXPRESSION 	The EXPRESSION is false.
-n STRING 	The length of STRING is greater than zero.
-z STRING 	The lengh of STRING is zero (ie it is empty).
STRING1 = STRING2 	STRING1 is equal to STRING2
STRING1 != STRING2 	STRING1 is not equal to STRING2
INTEGER1 -eq INTEGER2 	INTEGER1 is numerically equal to INTEGER2
INTEGER1 -gt INTEGER2 	INTEGER1 is numerically greater than INTEGER2
INTEGER1 -ge INTEGER2   INTEGER1 is numerically greater than or equal to INTEGER2
INTEGER1 -lt INTEGER2 	INTEGER1 is numerically less than INTEGER2
INTEGER1 -le INTEGER2   INTEGER1 is numerically less than or equal to INTEGER2
-d FILE 	FILE exists and is a directory.
-e FILE 	FILE exists.
-r FILE 	FILE exists and the read permission is granted.
-s FILE 	FILE exists and its size is greater than zero (ie. it is not empty).
-w FILE 	FILE exists and the write permission is granted.
-x FILE 	FILE exists and the execute permission is granted.

# Boolean Operators
 and - &&
 or - ||