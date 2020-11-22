#!/bin/bash

# array methods BASH
#Syntax	#Result

arr=()	#Create an empty array
arr=(1 2 3)	#Initialize array
${arr[2]}	#Retrieve third element
${arr[@]}	#Retrieve all elements
${!arr[@]}	#Retrieve array indices
${#arr[@]}	#Calculate array size
arr[0]=3	#Overwrite 1st element for integer 3
arr+=(4)	#Append value(s)
unset arr[index ou elemento] # remove objetos da lista, podendo ser refenciados pelo indice ou pelo próprio elemento
str=$(ls)	#Save ls output as a string
arr=( $(ls) )	#Save ls output as an array of files
${arr[@]:s:n}	#Retrieve n elements starting at index s

read -ra array <<< "$string" # determinada string eh lida como uma lista 'array' de acordo com um delimitador. Por padrão é espaço em branco. Eh possivel alterar com a variavel IFS='delimitador'.
#IFS=$'\t' # break strings (tabulation).
