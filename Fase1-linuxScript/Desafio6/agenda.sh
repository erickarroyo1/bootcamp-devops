#!/bin/bash
while :
do
	#Menu
	clear
	echo -e "\e[1;32m"
	echo " MENU AGENDA"
	echo ""
	echo "1. Añadir (añadir un registro)"
	echo "2. Buscar (buscar entradas por nombre, dirección o teléfono)"
	echo "3. Listar (visualizar todo el archivo)."
	echo "4. Ordenar (ordenar los registros alfabéticamente)."
	echo "5. Borrar (borrar el archivo)."
	echo "6. Salir"
	echo ""
	#Escoger menu
	echo -n "Escoger opcion: "
	read opcion
	#Seleccion de menu
	case $opcion in
		1) echo -e "Añadir registro a lista.txt\n"
			read -p "introduce un registro seguido por comas (nombre,dirección,teléfono): " registro
			echo $registro >> lista.txt
			echo -e "\nregistro ${registro} agregado correctamente a lista.txt"
			read foo
			;;
		2) echo -e "Buscar (buscar entradas por nombre, dirección o teléfono)\n"
			read -p "introduce un dato de busqueda (nombre, dirección o teléfono" dato_busqueda
			cat lista.txt | grep $dato_busqueda
			read foo
			;;
		3) echo -e "Listar (visualizar todo el archivo)\n"
			cat lista.txt
			read foo
			;;
		4) echo -e "Ordenar (ordenar los registros alfabéticamente)\n"
			cat lista.txt | sort
			read foo
			;;
		5) echo -e "Borrar (borrar el archivo)\n"
			rm -rf lista.txt
			echo "\nborrado procesado de lista.txt"
			read foo
			;;
		6) exit 0;;
		#Alerta
		*)echo "Opcion invalida..."
		sleep 1
esac
done
