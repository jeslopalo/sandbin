
function available_dotfiles() {
    local group="$1"
    local dotfiles_home=${SANDBIN_HOME}/dotfiles/

    if [ -z $group ]; then
        local curated_dotfiles_home=${dotfiles_home//\//\\\/}
        find "$SANDBIN_HOME/dotfiles" -maxdepth 2 -mindepth 2 -type f -name '*.template' | sed "s/$curated_dotfiles_home//" | sed 's/\..*//'

    elif [ -d "$dotfiles_home$group" ]; then
        local curated_dotfiles_home=${dotfiles_home//\//\\\/}${group//\//\\\/}\\\/
        find "$SANDBIN_HOME/dotfiles/$group" -maxdepth 1 -mindepth 1 -type f -name '*.template' | sed "s/$curated_dotfiles_home//" | sed 's/\..*//'
    else
        printf "${RED}Sorry! There is no ${BOLD}%s${NORMAL}${RED} group of dotfile templates${NORMAL}\n" "$group" 1>&2
        return 1
    fi
    return 0
}

function install_dotfile() {
    local name="$1"
    local directory="$(echo $2 | sed 's/\/*$//')"
    local template="$SANDBIN_HOME/dotfiles/$name.template"
    local group=$(echo $name | sed 's/\/.*//')

    if [ -z "$name" ]; then
        printf "I need a dotfile name to be installed\n" 1>&2
        return 1
    fi

    init_template "$name"
    if [ -z "$directory" ]; then
        directory="$DOTFILES_DEFAULT_INSTALL_DIRECTORY"
    fi

    if [ ! -f "$template" ]; then
        printf "'%s' dotfile template doesn't exists\n" "$name" 1>&2
        return 1
    fi

    if [ -d "$directory/.$group" ]; then
        printf "${RED}Sorry! There is a directory (${BOLD}%s${NORMAL}${RED}) with the same name.${NORMAL}\n" "$directory/.$group" 1>&2
        return 1
    fi

    if [ -f "$directory/.$group" ]; then
        printf "The file already exists, creating backup [%s]...\n" "$directory/.$group.backup"
        mv "$directory/.$group" "$directory/.$group.backup"
    fi

    printf "Installing ${BOLD}%s${NORMAL} dotfile template [in '%s']...\n" "$name" "$directory/.$group"
    cp "$template" "$directory/.$group"

    return $?
}

function init_template() {
    local name=$(echo "$1" | sed 's/.*\///')
    local group=$(echo "$1" | sed 's/\/.*//')

    if [ -f "$SANDBIN_HOME/dotfiles/$group/default.rc" ]; then
        source "$SANDBIN_HOME/dotfiles/$group/default.rc"
    fi

    if [ "$name" != "default" ] && [ -f "$SANDBIN_HOME/dotfiles/$group/$name.rc" ]; then
        source "$SANDBIN_HOME/dotfiles/$group/$name.rc"
    fi

    if [ -z "$DOTFILES_DEFAULT_INSTALL_DIRECTORY" ]; then
        DOTFILES_DEFAULT_INSTALL_DIRECTORY=~
    fi
}
