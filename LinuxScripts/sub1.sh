#!/bin/bash

#sudo apt install gparted
#sudo apt install calibre

sudo groupadd profesori
sudo groupadd studenti
sudo groupadd FacA
sudo groupadd FacB
sudo groupadd FacC



#studenti=$(cut -f1 -d, $detalii_studenti)
#facultate=$(cut -f2 -d, $detalii_studenti)

i=$(cat $1 |wc -l)
k=1
while [ $k -le $i ]
do
	line=$(sed -n $k"p" $1)
	 let k++

	 fac=$(echo $line | cut -f3 -d,)
	 nume=$(echo $line| cut -f2 -d,| cut -f1 -d" ")
	 initiala=$(echo $line|cut -f2 -d, |cut -f2 -d" " |egrep -o "^[A-Z]")
	 nr_matricol=$(echo $line |cut -f1 -d,)

	 user=$fac"_"$initiala$nume
	 user=${user,,}
	 
	 facultate="Fac"$fac
	 sudo useradd -c $nr_matricol -g studenti -G $facultate -d /home/studenti/$user -m $user
done	


i=$(cat $2| wc -l)

k=1

while [ $k -le $i]
do
	line=$(sed -n $k"p" $2)
	let k++
	nume=$(echo $line | cut -f1 -d, |cut -f1 -d" ")
	prenume=$(echo $line | cut -f1 -d, |cut -f2 -d" ")
	
	user=$prenume"_"$nume

	sudo useradd -g profesori -d /home/profesori/$user -s /bin/bash

done


