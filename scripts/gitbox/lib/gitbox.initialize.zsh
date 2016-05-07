source "${SANDBIN_HOME}/scripts/lib/usage.lib.zsh"
source "${SANDBIN_HOME}/scripts/lib/colors.lib.zsh"
source "${SANDBIN_HOME}/scripts/lib/git-functions.lib.zsh"

function usage_initialize() {
    local mode=$(usage_mode $1)
    local color=$(usage_description_color $mode $2)

    $(usage_show_description $mode) && printf "${color}Initialize a new git repository (git & git flow)${NORMAL}\n"
    $(usage_show_usage $mode) && printf "usage: ${BOLD}gitbox initialize${NORMAL} [-f, --force] [-s, --server] [-h, --help]\n"

    if usage_show_detailed $mode; then
        printf "\nOptions:\n"
        printf "    ${BOLD}-f, --force${NORMAL}     Force to initialize git flow\n"
        printf "    ${BOLD}-s, --server${NORMAL}    Initialize a git bare shared repository\n"
        printf "    ${BOLD}-h, --help${NORMAL}      Display this help\n"
    fi
}

function gitbox_initialize() {

    while [[ $# > 0 ]]; do
        key="$1"

        case $key in
            -f|--force)
                force=$key
            ;;
            -s|--server)
                if is_a_git_workspace; then
                    printf "${RED}gitbox initialize: The '%s' directory is already a git repository!${NORMAL}\n" $(pwd)
                    exit 1
                fi
                printf "Initializing git bare shared repository in '%s' directory...\n" $(pwd)
                git init --bare --shared
                exit $?
            ;;
            -h|--help)
                usage_initialize "help"
                exit 0
            ;;
            *)
                printf "${RED}gitbox initialize: Ouch! Unknown option '%s'. Please try agan!${NORMAL}\n" "$key"
                usage_initialize
                exit 1
            ;;
        esac

        shift;
    done

    if is_a_git_workspace; then
        printf "${YELLOW}The '%s' directory is already a git repository!${NORMAL}\n" $(pwd)
        git_flow_init $force

    else
        git init
        git_flow_init $force
    fi

    exit $?
}
