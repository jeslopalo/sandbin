#!/bin/bash

usage() {
	echo -e "usage: ./git-init.sh \"User Name\" user@name.es"
}

if [ $# -lt 1 ]; then
	usage
	exit 1
fi

username=$1
email=$2

set -e

echo -e "Configuring username and email as repository properties..."
git config user.name "$username"
git config user.email "$email"

echo -e "Configuring aliases for log command..."

echo -e "New comand: git lol"
git config alias.lol "log --pretty=oneline --abbrev-commit --graph --decorate"


echo -e "Configuring aliases for unstage changes..."
git config alias.unstage "reset HEAD"
