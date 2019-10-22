#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

if (! [[ -f ~/.todo ]]) && [[ $1 == "add" ]]
then
	echo 0:u:$2 > ~/.todo
	echo TaskId: 0
elif (! [[ -f ~/.todo ]])
then
	echo -e "$RED"No notes avaliable $NC
else
	case $1 in
		add)
			last_note=$(tail -n 1 ~/.todo | awk -F: '{print ++$1}')
			echo TaskId: $last_note
			echo $last_note:u:$2 >> ~/.todo
			;;
		complete)
			sed -ri 's|(^'"$2"':)u|\1c|g' ~/.todo
			;;
		todo)
			sed -r "/^.*:c/d" ~/.todo | awk -F: '{print $3}'
			;;
		done)
			sed -r "/^.*:u/d" ~/.todo | awk -F: '{print $3}'
			;;
		rm)
			sed -ri "/^$2:/d" ~/.todo
			;;
		all)
			echo -e "$GREEN"Done: $NC
			sed -r "/^.*:u/d" ~/.todo | awk -F: '{print "\t"$1": "$3}'
			echo -e "$RED"ToDo: $NC
			sed -r "/^.*:c/d" ~/.todo | awk -F: '{print "\t"$1": "$3}'
			;;

		esac
fi
