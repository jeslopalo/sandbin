source "${SANDBIN_HOME}/scripts/lib/colors.lib.zsh"
source "${SANDBIN_HOME}/scripts/lib/git-functions.lib.zsh"

function usage-initialize() {
    local mode="$1"

    [ "$mode" = "help" ] && printf "${CYAN}Initialize a new git repository (git & git flow)${NORMAL}\n"
    printf "usage: ${BOLD}gitbox initialize${NORMAL} [-f, --force] [-s, --server] [-h, --help]\n"

    if [ "$mode" = "help" ]; then
        printf "\nOptions:\n"
        printf "    ${BOLD}-f, --force${NORMAL}     Force to initialize git flow\n"
        printf "    ${BOLD}-s, --server${NORMAL}    Initialize a git bare shared repository\n"
        printf "    ${BOLD}-h, --help${NORMAL}      Display this help\n"
    fi
}

function gitbox-initialize() {

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
                usage-initialize "help"
                exit 0
            ;;
            *)
                printf "${RED}gitbox initialize: Ouch! Unknown option '%s'. Please try agan!${NORMAL}\n" "$key"
                usage-initialize
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
