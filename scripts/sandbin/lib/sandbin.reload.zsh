source "${SANDBIN_HOME}/scripts/lib/colors.lib.zsh"
source "${SANDBIN_HOME}/scripts/sandbin/lib/sandbin.lib.zsh"

function sandbin_reload() {
    source "$SANDBIN_HOME/sandbinrc"
    printf "${WHITE}%s${NORMAL}\n" "Hooray! your sandbin session has been reloaded!"
}