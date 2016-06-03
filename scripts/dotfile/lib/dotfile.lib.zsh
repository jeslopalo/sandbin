
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
