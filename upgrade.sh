#!/bin/bash

set -e

# Use colors, but only if connected to a terminal, and that terminal
# supports them.
tput=$(which tput)
if [ -n "$tput" ]; then
    ncolors=$(tput colors)
fi
if [ -t 1 ] && [ -n "$ncolors" ] && [ "$ncolors" -ge 8 ]; then
  RED="$(tput setaf 1)"
  GREEN="$(tput setaf 2)"
  YELLOW="$(tput setaf 3)"
  BLUE="$(tput setaf 4)"
  BOLD="$(tput bold)"
  NORMAL="$(tput sgr0)"
else
  RED=""
  GREEN=""
  YELLOW=""
  BLUE=""
  BOLD=""
  NORMAL=""
fi

if [ ! -n "$SANDBIN_HOME" ]; then
	SANDBIN_HOME=~/.sandbin
fi

if [ ! -d "$SANDBIN_HOME" ]; then
	echo "You have not sandbin installed. You'll need to install sandbin"
    exit
fi

printf "${BLUE}%s${NORMAL}\n" "Upgrading sandbin"
cd "$SANDBIN_HOME"
if git pull --rebase --stat origin master
then
  printf '%s' "$GREEN"
  printf '%s\n' '                                          oooo oooo       o88'
  printf '%s\n' ' oooooooo8    ooooooo   oo oooooo    ooooo888   888ooooo  oooo  oo oooooo'
  printf '%s\n' '888ooooooo    ooooo888   888   888 888    888   888    888 888   888   888'
  printf '%s\n' '        888 888    888   888   888 888    888   888    888 888   888   888 '
  printf '%s\n' '88oooooo88   88ooo88 8o o888o o888o  88ooo888o o888ooo88  o888o o888o o888o '
  printf '%s\n' ''
  printf "${BLUE}%s\n" "Hooray! Sandbin has been updated and/or is at the current version."
else
  printf "${RED}%s${NORMAL}\n" 'There was an error updating. Try again later?'
fi
