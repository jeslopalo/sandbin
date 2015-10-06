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

echo -e "New command: git changelog"
git config alias.changelog "log --pretty=oneline --abbrev-commit --decorate --color"
# TODO: See if it's possible to stop in previous release
#git log v2.1.0...v2.1.1 --pretty=format:'<li> <a href="http://github.com/jeslopalo/<project>/commit/%H">view commit &bull;</a> %s</li> ' --reverse | grep "#changelog"

echo -e "New command: git authors"
git config alias.authors '!git log --all --format="%aN <%aE>" | sort -u'

echo -e "Configuring aliases for unstage changes..."
git config alias.unstage "reset HEAD"
