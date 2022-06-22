#!/bin/bash


if ! [[ -f $1 ]]
then
	echo "Fisierul nu este de tip regular file"
	exit 1
fi
echo "A:"
egrep "> 10\.3" $1

echo "B:"
sed -Ei "s/IP ([0-9]{1,3}\.)([0-9]{1,3}\.)([0-9]{1,3}\.)([0-9]{1,3})/IP \1\*.\3\4/g" $1
cat $1

echo "C:"

vector=$(cut -f3,5 -d" " <traffic.txt |cut -f1 -d:)

for IP in ${vector[*]}
do
	ping $IP
done

echo "D:"

adrese=$(ip a | egrep "inet " | cut -f6 -d" " |cut -f1 -d"/")

for ip in ${adrese[*]}
do
	if cat $1 | egrep "$ip"
	then
		echo "Adresa $ip se regaseste"
	fi
done

echo "E:"

dimensiuni=$(egrep -o "[0-9]*$" $1)

sum=0

for value in ${dimensiuni[*]}
do
	let sum=$sum+$value
done

echo "F:"

echo "Trafic ssh sursa:"
egrep "\.22 >" $1

echo "Trafic ssh destinatie"
egrep "\.22:" $1



