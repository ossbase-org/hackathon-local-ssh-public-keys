#!/bin/bash
ROOT="/root/hackathon-local-ssh-public-keys"
FILE="$ROOT/hackathon-2025.txt"
EMAIL="sascha@rommelfangen.de"
ARGC=$#
if [[ $ARGC == 0 ]]
then
	for valid_user in `ssh-keygen -l -f $FILE |cut -d " " -f 3`
	do
		cat $FILE | grep $valid_user
	done
	exit 0
fi

if [[ $ARGC -gt 0 ]]
then
	COMMANDS="git ssh-keygen mail useradd cut id"
	if ! which $COMMANDS
	then
		echo "Please install missing software. Required software is:\n$COMMANDS"
		exit 1
	fi
 
	cd $ROOT
	git pull
	if ! ssh-keygen -l -f $FILE 2>&1 >/dev/null
	then
		echo -e "We have a problem with a public key.\n\nPlease check the repository at https://github.com/ossbase-org/hackathon-local-ssh-public-keys\n" \
		       	| mail -s "Public Key Problem" $EMAIL
	fi
	for valid_user in `ssh-keygen -l -f $FILE |cut -d " " -f 3`
	do
		if id $user
		then
			useradd -m -s /bin/bash $valid_user
		else
			echo "User $valid_user exists"
		fi
	done
fi
