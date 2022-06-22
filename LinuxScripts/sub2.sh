#!/bin/bash

echo "Procese"

ps -o pid,args,%cpu| egrep "[1-9][0-9]\.[0-9]+$"

echo "B:"
ps -eo pid,args | egrep "sleep"

sleep=$(ps -eo args |egrep "sleep")
nc=$(ps -eo args|egrep "nc")
nmap=$(ps -eo args |egrep "nmap")
script=$(ps -eo args |egrep "*\.sh")

if [[ -n $sleep ]]
then
	ps -eo pid,user,args |egrep "sleep"
fi

if [[ -n $nc ]]
then
	ps -eo pid,user,args |egrep "nc"
fi


if [[ -n $nmap ]]
then
	ps -eo pid,user,args |egrep "nmap"
fi


if [[ -n $script ]]
then
	ps -eo pid,user,args |egrep "*\.sh"
fi

echo "Utilizatori:"


echo "Din grupul root:"
cat /etc/passwd | egrep ":root:"|cut -f1 -d:


echo "Din grupul sudo:"
cat /etc/passwd | egrep ":sudo:"|cut -f1 -d:

echo "Din grupul adm:"
cat /etc/passwd | egrep ":adm:"|cut -f1 -d:

echo "Utilizatori cu /bin/bash:"
cat /etc/passwd | egrep "/bin/bash$" |cut -f1 -d:

echo "fisiere"


k=1
file=$(echo $PATH |cut -f$k -d":")
while [ true ]
do
        let k=$k+1
        echo $file
        file=$(echo $PATH |cut -f$k -d":")

        if [ -z $file ]
        then
                break
        fi

	suid=$(ls -l $file | egrep "\-[rw]+S")
	if ! [[ -z $suid ]]
	then
		echo "Fisierul $file are SUID setat"
	fi
done

owner=$(stat -c "%U" /etc/passwd)

if [ $owner=="root" ]
then
	echo "Ownerul este root"
fi

permisiune=$(ls -l /etc/passwd | egrep "\-\-\-$")

if [ -z $permisiune ]
then
	echo "Are permisiuni pentru other"
fi




