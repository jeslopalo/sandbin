function usage-init() {
    printf "'${YELLOW}gitbox init${NORMAL}' initialize a new git repository\n"
    printf "${YELLOW}%s${NORMAL}\n" "usage: gitbox init [-f | -h, --help]"
}

function gitbox-init() {

    while [[ $# > 0 ]]; do
        key="$1"

        case $key in
            -f)
                force=$key
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

    if [ -d "./.git" ]; then
        printf "${YELLOW}The '%s' directory is already a git repository!${NORMAL}\n" $(pwd)
    else
        printf "Initializing git in '%s' directory...\n" $(pwd)
        git init
    fi

    printf "Initializing git flow in '%s' directory...\n" $(pwd)
    git flow init $force
    exit $?
}
