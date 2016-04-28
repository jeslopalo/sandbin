function usage-setup() {
    printf "'${YELLOW}gitbox setup${NORMAL}' provides several utilities to configure git\n"
    printf "${YELLOW}%s${NORMAL}\n" "usage: gitbox setup [aliases | attributes | user | email | -h, --help]"
}

function gitbox-setup() {

    while [[ $# > 0 ]];  do
        key="$1"

        case $key in
            aliases)
                shift
                gitbox-setup-aliases "$@"
                exit $?
            ;;
            attributes)
                shift
                gitbox-setup-attributes "$@"
                exit $?
            ;;
            user)
                shift
                gitbox-setup-attribute "user.name" "$@"
                exit $?
            ;;
            email)
                shift
                gitbox-setup-attribute "user.email" "$@"
                exit $?
            ;;
            -h|--help)
                usage-setup
                exit 0
            ;;
            *)
                printf "${RED}%s${NORMAL}\n" "Ouch! Unknown option '$key'. Please try agan!"
                usage-setup
                exit 1
            ;;
        esac

        shift;
    done

    printf "${RED}%s${NORMAL}\n" "Ouch! There is not enough parameters 'gitbox setup [subcommand]'"
    usage-setup
    exit 1
}

function gitbox-setup-aliases-usage() {
    printf "%s\n" "usage: gitbox setup aliases <scope> [-c | --clean-aliases] [<aliases file prefix>] [-h | --help]"
    printf "\t- ${BOLD}scope:${NORMAL} --system | --global | --local\n"
}

function gitbox-setup-aliases() {

    while [[ $# > 0 ]];  do
        key="$1"

        case $key in
            --system|--global|--local)
                scope=$key
            ;;
            -c|--clean-aliases)
                clean_aliases=$key
            ;;
            -h|--help)
                gitbox-setup-aliases-usage
                return 0
            ;;
            *)
                aliases_file_prefix=$key
            ;;
        esac

        shift;
    done

    if ! is_a_git_workspace; then
        printf "${RED}Ouch! I need a git repository to work${NORMAL}\n"
        return 1;
    fi

    if [ -z $scope ]; then
        printf "${RED}Ouch! I need a scope (ie. --system, --global, --local) to setup aliases${NORMAL}\n"
        return 1;
    fi

    if [ ! -z $clean_aliases ]; then
        printf "${YELLOW}Cleaning aliases in %s scope...${NORMAL}\n" "$scope"
        git config $scope --remove-section alias 2> /dev/null
    fi

    if [ -z $aliases_file_prefix ]; then
        aliases_file_prefix="default"
    fi

    source "${SANDBIN_HOME}/dotfiles/gitaliases/${aliases_file_prefix}.gitaliases"
}

function gitbox-setup-attributes-usage() {
    printf "%s\n" "usage: gitbox setup attributes [--to-dir <directory>] [-F | --force] [<attributes file prefix>] [-h | --help]"
}

function gitbox-setup-attributes() {

    while [[ $# > 0 ]];  do
        key="$1"

        case $key in
            --to-dir)
                if [ ! -d "$2" ]; then
                    printf "${RED}Ouch! '%s' doesn't seem to be a valid directory.${NORMAL}\n" "$2"
                    exit 1
                fi
                directory="$2"
                shift
            ;;
            -F|--force)
                force=true
            ;;
            -h|--help)
                gitbox-setup-attributes-usage
                exit 0
            ;;
            *)
                attributes_file_prefix="$1"
            ;;
        esac
        shift
    done

    if [ -z "$directory" ]; then
        directory="."
    fi
    installation_path=$directory/.gitattributes

    if ! is_a_git_workspace $directory; then
        printf "${RED}Ouch! I need a git repository to work${NORMAL}\n"
        exit 1;
    fi

    if [ -z $attributes_file_prefix ]; then
        attributes_file_prefix="default"
    fi

    if [ ! -f "$installation_path" ] || [ $force ] ; then

        if [ -f "$installation_path" ]; then
            printf "${YELLOW}Forcing to rewrite existing .gitattributes file ['%s'] (Saving a copy in %s)${NORMAL}\n" "$installation_path" "$installation_path.oldBackup"
            mv "$installation_path" "$installation_path.oldBackup"
        fi

        printf "${GREEN}Creating .gitattributes file ['%s'] from %s.gitattributes template.${NORMAL}\n" "$installation_path" "$attributes_file_prefix"
        cp "$SANDBIN_HOME/dotfiles/gitattributes/$attributes_file_prefix.gitattributes" "$installation_path"
        return $?
    else
        printf "The file ${RED}'%s'${NORMAL} already exists! (use -F,--force to rewrite)\n" "$installation_path"
        return 1
    fi
}

function gitbox-setup-attribute-usage() {
    local attribute="$1"
    local scope="$2"

    if [ -z $scope ]; then
        printf "usage: gitbox setup %s <scope> <%s value>\n" "$attribute" "$attribute"
        printf "\t- ${BOLD}scope:${NORMAL} --system | --global | --local\n"
    else
        printf "usage: gitbox setup %s %s <%s value>\n" "$attribute" "$scope" "$attribute"
    fi
}

function gitbox-setup-attribute() {

    local attribute="$1"
    shift;

    while [[ $# > 0 ]];  do
        key="$1"

        case $key in
            -h|--help)
                gitbox-setup-attribute-usage $attribute $scope
                return 0;
            ;;
                --system|--global|--local)
                scope="$1"
            ;;
            *)
                value="$1"
            ;;
        esac
        shift;
    done

    if [ -z $value ] || [ -z $scope ]; then
        printf "${RED}%s${NORMAL}\n" "Ouch! There is not enough parameters."
        gitbox-setup-attribute-usage $attribute $scope
        exit 1
    fi

    set_git_attribute "$attribute" "$scope" "$value"
    if (( $? )); then
        printf "${RED}Ouch! '$BOLD%s$NORMAL$RED' has not been configured as $BOLD%s$NORMAL$RED in %s scope. It's '%s' a git repository?${NORMAL}\n" "$value" "$attribute" "$scope" "$(pwd)";
    else
        printf "${GREEN}Great! '$BOLD%s$NORMAL$GREEN' has been configured as $BOLD%s$NORMAL$GREEN in %s scope ${NORMAL}\n" "$(get_git_attribute $attribute $scope)" "$attribute" "$scope";
    fi
}
