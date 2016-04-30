source "${SANDBIN_HOME}/scripts/lib/colors.lib.zsh"
source "${SANDBIN_HOME}/scripts/sandbin/lib/sandbin.lib.zsh"


function sandbin_version() {
    print_sandbin_banner "$(sandbin_branch)" "${BLUE}"
}
