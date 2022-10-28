#!/bin/bash

parametro=$1

str1=""

if  [ $parametro == $str1 ]; then
	echo 'Error, debe colocar la ruta de un archivo como parámetro'
else
	echo '-------------------------------------'
	echo -e '-------------------------------------\n\n'
	
	wc -l $parametro
fi

