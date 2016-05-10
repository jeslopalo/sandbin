source "${SANDBIN_HOME}/scripts/lib/colors.lib.zsh"
source "${SANDBIN_HOME}/scripts/sandbin/lib/sandbin.lib.zsh"

function sandbin_upgrade() {

    version=$(sandbin_version)

    printf "${BLUE}%s${NORMAL}\n" "Upgrading sandbin installation [$SANDBIN_HOME] to $version"

    cd "$SANDBIN_HOME"
    if git pull --rebase --stat origin "$version"
    then
        print_sandbin_banner "$version"
        printf "${YELLOW}%s${NORMAL}\n" "Hooray! Sandbin has been updated and/or is at the current version."
        printf "${UNDERLINE}${BRIGHT_WHITE}%s${REMOVE_UNDERLINE}${NORMAL}\n" "Remember to reload your sandbin session running 'sandbin reload' in your shell."

    else
        printf "${RED}%s${NORMAL}\n" 'There was an error updating. Try again later?' 1>&2
    fi
}
