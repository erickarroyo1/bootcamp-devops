#!/bin/bash

hora=$(date +'%H')

echo $hora


if  [ $hora -gt 08 ] && [ $hora -lt 15 ]; then

	echo "Buenos Días."
elif [ $hora -gt 15 ] && [ $hora -lt 20 ]; then
	echo "Buenas Tardes."
else
	echo "Buenas Noches"
fi
