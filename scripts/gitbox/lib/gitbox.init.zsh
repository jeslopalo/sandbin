source "${SANDBIN_HOME}/scripts/lib/git-functions.lib.zsh"

function usage-init() {
    printf "'${YELLOW}gitbox init${NORMAL}' initialize a new git repository\n"
    printf "${YELLOW}%s${NORMAL}\n" "usage: gitbox init [-f, --force | -s, --server | -h, --help]"
}

function gitbox-init() {

    while [[ $# > 0 ]]; do
        key="$1"

        case $key in
            -f|--force)
                force=$key
            ;;
            -s|--server)
                server="true"
            ;;
            -h|--help)
                usage-init
                exit 0
            ;;
            *)
                printf "${RED}%s${NORMAL}\n" "Ouch! Unknown option '$key'. Please try agan!"
                usage-init
                exit 1
            ;;
        esac

        shift;
    done

    if is_a_git_workspace; then
        printf "${YELLOW}The '%s' directory is already a git repository!${NORMAL}\n" $(pwd)
        git_flow_init $force

    elif [ "$server" = "true" ]; then
        printf "Initializing git bare shared repository in '%s' directory...\n" $(pwd)
        git init --bare --shared

    else
        printf "Initializing git repository in '%s' directory...\n" $(pwd)
        git init
        git_flow_init $force
    fi

    exit $?
}
