#!/bin/bash

LIST=("." "." "." "." "." "." "." "." ".")
WIN=("012" "345" "678" "036" "147" "258" "048" "246")
END=0
USER=1
COUNTER=0

function CHECK {
	for W in ${WIN[@]}
	do
		if [ ${LIST[${W:0:1}]} = ${LIST[${W:1:1}]} ] && [ ${LIST[${W:1:1}]} = ${LIST[${W:2:1}]} ] && [  "${LIST[${W:0:1}]}" != "." ];
		then
			echo "User$USER won!"
			END=1
			break
		fi
	done	
}

function DISPLAY {
	i=1
	for A in ${LIST[@]}
	do
		if [ $i = 0 ]
		then
			echo -e "$A "
		else
			echo -n "$A "
		fi
		let "i += 1"
		let "i %= 3"
	       	
	done
}

while [ $END = 0 ]
do

	if [ $COUNTER = 9 ]
	then
		echo "Draw!"
		break
	fi
	echo "User$USER move:"
	read MOVE	
	if [[ $MOVE =~ ^[1-9]$ ]]
	then
		if [ ${LIST[ MOVE - 1 ]} = "." ]
		then
			if [ $USER = 1 ];
			then
				LIST[MOVE - 1]="X"
				let "COUNTER += 1"
				CHECK
				USER=2
			else
				LIST[MOVE - 1]="O"
				let "COUNTER += 1"
				CHECK
				USER=1
			fi
		else
			echo "Field is already taken"
		fi
	else
		echo "Wrong field choose field between 1 and 9"
	fi
	DISPLAY
done

