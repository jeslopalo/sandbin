#!/usr/bin/env bash

function print_sandbin_banner() {
    local banner_color=$1;
    local branch=`git rev-parse --abbrev-ref HEAD`;

    if [ -z "$banner_color" ]; then
        banner_color="${GREEN}"
    fi

    printf '%s' "$banner_color"
    printf '%s\n' ''
    printf '%s\n' '                                          oooo oooo       o88'
    printf '%s\n' ' oooooooo8    ooooooo   oo oooooo    ooooo888   888ooooo  oooo  oo oooooo'
    printf '%s\n' '888ooooooo    ooooo888   888   888 888    888   888    888 888   888   888'
    printf '%s\n' '        888 888    888   888   888 888    888   888    888 888   888   888 '
    printf '%s\n' '88oooooo88   88ooo88 8o o888o o888o  88ooo888o o888ooo88  o888o o888o o888o '
    printf '%s\n' ''
    printf "%s\n" "${RED}                                                           revision: $branch${NORMAL}"
}

function sandbin_upgrade() {

    printf "${BLUE}%s${NORMAL}\n" "Upgrading sandbin"
    cd "$SANDBIN_HOME"

    if git pull --rebase --stat origin master
    then
        sandbin_reload
        print_sandbin_banner
        printf "${YELLOW}%s\n" "Hooray! Sandbin has been updated and/or is at the current version."

    else
        printf "${RED}%s${NORMAL}\n" 'There was an error updating. Try again later?'
    fi
}

function sandbin_reload() {
    source "$SANDBIN_HOME/sandbinrc"

    print_sandbin_banner "${YELLOW}"
}