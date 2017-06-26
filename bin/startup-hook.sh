#!/usr/bin/env bash

lastLogin=$(last -1 -R $USER | head -1)
tmpStartupFile="/tmp/tmpAwesomeStartupFile"
startupItems=(
	"insync start"
)

if [[ $(cat $tmpStartupFile | tr -d '\n|\r|\t|\f') == $(echo $lastLogin | tr -d '\n|\r|\t|\f') ]];
	then
		printf "Startup already completed\n"
	else		
		printf "Starting startup items\n"
		for i in "${startupItems[@]}"
		do
			echo $i
		        printf "\e[1;36m> Starting %s:\n\e[m" "$i"
	        	$i & disown
		done
		echo $lastLogin > $tmpStartupFile
fi

