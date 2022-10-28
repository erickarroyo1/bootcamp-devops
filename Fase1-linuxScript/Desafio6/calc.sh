#!/bin/bash 

read -p "introduce un número para 'a': " a
read -p "introduce otro número para 'b': " b
read -p "introduce un tercer número para 'c': " c

op1=$((a%b))
op2=$((a/c))
op3=$((2 * b + 3 * (a-c)))
op4=$((a * (b/c)))
op5=$(((a*c)%b))

echo "la operación (a%b) da como resultado $op1"
echo "la operación (a/c) da como resultado $op2"
echo "la operación (2 * b + 3 * (a-c)) da como resultado $op3"
echo "la operación (a * (b/c)) da como resultado $op4"
echo "la operación ((a*c)%b) da como resultado $op5"






