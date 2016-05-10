source "${SANDBIN_HOME}/scripts/lib/colors.lib.zsh"
source "${SANDBIN_HOME}/scripts/sandbin/lib/sandbin.lib.zsh"


function print_sandbin_version() {
    local version="$(sandbin_version)"

    print_sandbin_banner "$version" "${WHITE}${BOLD}"
    printf "\n"

    cd "$SANDBIN_HOME"
    gitbox changelog --tag "$version"
}
