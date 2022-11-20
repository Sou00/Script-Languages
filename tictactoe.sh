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
			if [[ $USER =~ ^[1-2]$ ]]
			then
				echo "Player$USER won!"
			else
				echo "PC won!"
			fi
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
function PLAYERMOVE {
	MOVE=$1
	let "MOVE -= 1"
	if [[ ${LIST[ $MOVE ]} = "." ]]
	then
		if [ $USER = 1 ];
		then
			LIST[$MOVE]="X"
			let "COUNTER += 1"
			CHECK
			if [ $2 = 1 ]
			then
				USER=2
			else
				USER=3
			fi
		else
			LIST[$MOVE]="O"
			let "COUNTER += 1"
			CHECK
			USER=1
		fi
	else
		echo "Field is already taken"
	fi
	}

function PCMOVE {
	
	MOVE=$((1 + $RANDOM % 9 ))

	while [ ${LIST[ MOVE - 1 ]} != "." ]
	do
		MOVE=$((1 + $RANDOM % 9 ))
	done
	LIST[MOVE - 1]="O"
	let "COUNTER += 1"
	CHECK
	USER=1
}


echo "Choose one of the options: "
echo "1. PLAYER VS PLAYER"
echo "2. PLAYER VS PC"
read OPTION
if [[ $OPTION =~ ^[1-2]$ ]]
then
	while [ $END = 0 ]
	do
		if [ $COUNTER = 9 ]
		then
			echo "Draw!"
			break
		fi
		if [[ $USER =~ ^[1-2]$ ]]
		then
			echo "Player$USER move:"
			read MOVE	
			if [[ $MOVE =~ ^[1-9]$ ]]
			then
				PLAYERMOVE $MOVE $OPTION
			elif [ "$MOVE" = "save" ]
			then
				echo "${LIST[@]}" > list.txt
				echo "$USER" > options.txt
				echo "$COUNTER" >> options.txt
				echo "$OPTION" >> options.txt	
			elif [ "$MOVE" = "load" ]
			then
				if [ -f "list.txt" ] && [ -f "options.txt" ]
				then
					readarray -t -d " " LIST < list.txt
					readarray -t OPTIONS < options.txt
					USER=${OPTIONS[0]}
					COUNTER=${OPTIONS[1]}
					OPTION=${OPTIONS[2]}
				else
					echo "There is no save to load!"
				fi
			else
				echo "Wrong field choose field between 1 and 9"
			fi
		else
			echo "PC move:"
			PCMOVE
		fi
		DISPLAY
	done
else
	echo "Wrong option!"
fi

