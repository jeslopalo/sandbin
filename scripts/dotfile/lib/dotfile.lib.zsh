
function available_dotfiles() {
    local group="$1"
    local dotfiles_home=${SANDBIN_HOME}/dotfiles/

    if [ -z $group ]; then
        local curated_dotfiles_home=${dotfiles_home//\//\\\/}
        find $SANDBIN_HOME/dotfiles -depth 2 -type f | sed "s/$curated_dotfiles_home//" | sed 's/\..*//'

    elif [ -d "$dotfiles_home$group" ]; then
        local curated_dotfiles_home=${dotfiles_home//\//\\\/}${group//\//\\\/}\\\/
        find $SANDBIN_HOME/dotfiles/$group -depth 1 -type f | sed "s/$curated_dotfiles_home//" | sed 's/\..*//'
    else
        printf "${RED}Sorry! There is no ${BOLD}%s${NORMAL}${RED} group of dotfile templates${NORMAL}\n" "$group" 1>&2
        return 1
    fi
    return 0
}

function install_dotfile() {
    local name="$1"
    local template="$SANDBIN_HOME/dotfiles/$name.template"
    local directory=~
    local group=$(echo $name | sed 's/\/.*//')

    if [ -z "$name" ]; then
        printf "I need a dotfile name to be installed\n" 1>&2
        return 1
    fi

    if [ ! -f "$template" ]; then
        printf "'%s' dotfile template doesn't exists\n" "$name" 1>&2
        return 1
    fi

    if [ -f "$directory/.$group" ]; then
        printf "The file already exists, creating backup [%s]..." "$directory/.$group"
        mv "$directory/.$group" "$directory/.$group.backup"
    fi

    printf "Installing ${BOLD}%s${NORMAL} dotfile template [in '%s']...\n" "$name" "$directory/.$group"
    cp "$template" "$directory/.$group"

    return $?
}
