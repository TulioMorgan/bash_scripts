#!/bin/bash

# Fonte com explicaoes de condicionais 'if': https://ryanstutorials.net/bash-scripting-tutorial/bash-if-statements.php

#basic if statements:

if [ <some test> ]
then
<commands>
elif [ <some test> ]
then
<different commands>
else
<other commands>
fi

# para pular a iteracao eh igual ao Python
continue
# para passar a iteracao, utilizar
:

case # Choose a set of commands to execute depending on a string matching a particular pattern.

# Uso geral
case EXPRESSION in

  PATTERN_1)
    STATEMENTS
    ;;

  PATTERN_2)
    STATEMENTS
    ;;

  PATTERN_N)
    STATEMENTS
    ;;

  *)
    STATEMENTS
    ;;
esac

# exemplo
case $i in *.c) echo Yes;; esac # se $i terminar com .c imprime Yes
