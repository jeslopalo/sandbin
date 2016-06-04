import "scripts/lib/usage.lib.zsh"
import "scripts/lib/git-functions.lib.zsh"

function usage_setup() {
    local mode=$(usage_mode $1)
    local color=$(usage_description_color $mode $2)

    $(usage_show_description $mode) && printf "${color}Provides several utilities to configure git${NORMAL}\n"
    $(usage_show_usage $mode) && printf "usage: ${BOLD}gitbox setup${NORMAL} [aliases | attributes | user | email] [-h, --help]\n"

    if usage_show_detailed $mode; then
        printf "\n"
        printf "    ${BOLD}aliases${NORMAL}         %s\n" "$(usage_setup_aliases description)"
        printf "    ${BOLD}attributes${NORMAL}      %s\n" "$(usage_setup_gitattributes description)"
        printf "    ${BOLD}user${NORMAL}            %s\n" "$(usage_setup_attribute user '' description)"
        printf "    ${BOLD}email${NORMAL}           %s\n" "$(usage_setup_attribute email '' description)"
        printf "\nOptions:\n"
        printf "    ${BOLD}-h, --help${NORMAL}      Display this help\n"
    fi
}

function usage_setup_aliases() {
    local mode=$(usage_mode $1)
    local color=$(usage_description_color $mode $2)

    $(usage_show_description $mode) && printf "${color}Setup git aliases for a scope${NORMAL}\n"
    $(usage_show_usage $mode) && printf "usage: ${BOLD}gitbox setup aliases${NORMAL} [--system | --global | --local] [-c, --clean-aliases] [<aliases file prefix>] [-h, --help]\n"

    if usage_show_detailed $mode; then
        printf "\n"
        printf "    ${BOLD}<aliases file prefix>${NORMAL}       %s\n" "Alias definition file prefix (defaults to default)"
        printf "\nOptions:\n"
        printf "    ${BOLD}--system${NORMAL}                    %s\n" "Setup in system scope (all users)"
        printf "    ${BOLD}--global${NORMAL}                    %s\n" "Setup in global scope (all user workspaces)"
        printf "    ${BOLD}--local${NORMAL}                     %s\n" "Setup in local scope (only for current workspace)"
        printf "    ${BOLD}-c, --clean-aliases${NORMAL}         %s\n" "First clean current scope aliases"
        printf "    ${BOLD}-h, --help${NORMAL}                  %s\n" "Display this help"
    fi
}

function usage_setup_gitattributes() {
    local mode=$(usage_mode $1)
    local color=$(usage_description_color $mode $2)

    $(usage_show_description $mode) && printf "${color}Setup .gitattributes file in a git repository${NORMAL}\n"
    $(usage_show_usage $mode) && printf "usage: ${BOLD}gitbox setup attributes${NORMAL}  [--to-dir <directory>] [-F | --force] [<attributes file prefix>] [-h | --help]\n"

    if usage_show_detailed $mode; then
        printf "\n"
        printf "    ${BOLD}<attributes file prefix>${NORMAL}    %s\n" ".gitattributes difinition file prefix (defaults to default)"
        printf "\nOptions:\n"
        printf "    ${BOLD}--to-dir <directory>${NORMAL}        %s\n" "Target directory to setup .gitattributes"
        printf "    ${BOLD}-F, --force${NORMAL}                 %s\n" "Replace .gitattributes file if already exists"
        printf "    ${BOLD}-h, --help${NORMAL}                  %s\n" "Display this help"
    fi
}

function usage_setup_attribute() {
    local attribute="$1"
    local attribute_name="$2"
    local mode=$(usage_mode $3)
    local color=$(usage_description_color $mode $4)

    $(usage_show_description $mode) && printf "${color}Setup '%s' git attribute${NORMAL}\n" "$attribute"
    $(usage_show_usage $mode) && printf "usage: ${BOLD}gitbox setup %s${NORMAL}  [--system | --global | --local] <%s> [-h | --help]\n" "$attribute_name" "$attribute_name"

    if usage_show_detailed $mode; then
        printf "\n"
        printf "    ${BOLD}<%s>${NORMAL}              %s\n" "$attribute_name" "Value for $attribute attribute"
        printf "\nOptions:\n"
        printf "    ${BOLD}--system${NORMAL}            %s\n" "Setup in system scope (all users)"
        printf "    ${BOLD}--global${NORMAL}            %s\n" "Setup in global scope (all user workspaces)"
        printf "    ${BOLD}--local${NORMAL}             %s\n" "Setup in local scope (only for current workspace)"
        printf "    ${BOLD}-h, --help${NORMAL}          %s\n" "Display this help"
    fi
}


function gitbox_setup() {

    if [ $# = 0 ]; then
        printf "${RED}gitbox setup: Ouch! There is not enough parameters 'gitbox setup [subcommand]'${NORMAL}\n" 1>&2
        usage_setup
        exit 1
    fi

    while [[ $# -gt 0 ]];  do
        key="$1"

        case $key in
            aliases)
                shift
                gitbox_setup_aliases "$@"
                exit $?
            ;;
            attributes)
                shift
                gitbox_setup_gitattributes "$@"
                exit $?
            ;;
            user)
                shift
                gitbox_setup_attribute "user.name" "$key" "$@"
                exit $?
            ;;
            email)
                shift
                gitbox_setup_attribute "user.email" "$key" "$@"
                exit $?
            ;;
            -h|--help)
                usage_setup "help"
                exit 0
            ;;
            *)
                printf "${RED}%s${NORMAL}\n" "Ouch! Unknown option '$key'. Please try agan!" 1>&2
                usage_setup
                exit 1
            ;;
        esac

        shift;
    done
}

function gitbox_setup_aliases() {

    while [[ $# -gt 0 ]];  do
        key="$1"

        case $key in
            --system|--global|--local)
                scope=$key
            ;;
            -c|--clean-aliases)
                clean_aliases=$key
            ;;
            -h|--help)
                usage_setup_aliases "help"
                return 0
            ;;
            *)
                alias_file_prefix=$key
            ;;
        esac

        shift;
    done

    if ! is_a_git_workspace; then
        printf "${RED}gitbox setup aliases: Ouch! I need a git repository to work${NORMAL}\n" 1>&2
        usage_setup_aliases
        return 1;
    fi

    if [ -z "$scope" ]; then
        printf "${RED}gitbox setup aliases: Ouch! I need a scope (ie. --system, --global, --local) to setup aliases${NORMAL}\n" 1>&2
        usage_setup_aliases
        return 1;
    fi

    if [ ! -z $clean_aliases ]; then
        printf "${YELLOW}Cleaning aliases in %s scope...${NORMAL}\n" "$scope"
        git config $scope --remove-section alias 2> /dev/null
    fi

    if [ -z "$alias_file_prefix" ]; then
        alias_file_prefix="default"
    fi

    import "scripts/gitbox/aliases/${alias_file_prefix}.aliases"
}

function gitbox_setup_gitattributes() {

    while [[ $# -gt 0 ]];  do
        key="$1"

        case $key in
            --to-dir)
                if [ ! -d "$2" ]; then
                    printf "${RED}gitbox setup attributes: Ouch! '%s' doesn't seem to be a valid directory.${NORMAL}\n" "$2" 1>&2
                    usage_setup_gitattributes
                    exit 1
                fi
                directory="$2"
                shift
            ;;
            -F|--force)
                force=true
            ;;
            -h|--help)
                usage_setup_gitattributes "help"
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
        printf "${RED}gitbox setup attributes: Ouch! I need a git repository to work${NORMAL}\n" 1>&2
        usage_setup_gitattributes
        exit 1;
    fi

    if [ -z "$attributes_file_prefix" ]; then
        attributes_file_prefix="default"
    fi
    template_path="$SANDBIN_HOME/dotfiles/gitattributes/$attributes_file_prefix.template"
    if [ ! -f $template_path ]; then
        printf "${RED}gitbox setup attributes: Ouch! I need a .gitattributes template and '%s' doesn't exists${NORMAL}\n" "$attributes_file_prefix.template" 1>&2
        usage_setup_gitattributes
        exit 1
    fi

    if [ ! -f "$installation_path" ] || [ $force ] ; then

        if [ -f "$installation_path" ]; then
            printf "${YELLOW}Forcing to rewrite existing .gitattributes file ['%s'] (Saving a copy in %s)${NORMAL}\n" "${installation_path#./}" "${installation_path#./}.backup"
            mv "$installation_path" "$installation_path.backup"
        fi

        printf "${GREEN}Creating .gitattributes file ['%s'] from %s.gitattributes template.${NORMAL}\n" "${installation_path#./}" "$attributes_file_prefix"
        cp "$template_path" "$installation_path"
        exit $?
    else
        printf "${RED}gitbox setup attributes: The file '%s' already exists! (use -F, --force to rewrite)${NORMAL}\n" "${installation_path#./}" 1>&2
        usage_setup_gitattributes
        exit 1
    fi
}

function gitbox_setup_attribute() {

    local attribute="$1"
    local attribute_name="$2"

    shift;
    shift;
    while [[ $# -gt 0 ]];  do
        key="$1"

        case $key in
            -h|--help)
                usage_setup_attribute $attribute $attribute_name "help"
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

    if [ -z "$value" ] || [ -z "$scope" ]; then
        printf "${RED}gitbox setup $attribute_name: Ouch! There is not enough parameters.${NORMAL}\n" 1>&2
        usage_setup_attribute $attribute $attribute_name
        exit 1
    fi

    set_git_attribute "$attribute" "$scope" "$value"
    if (( $? )); then
        printf "${RED}gitbox setup $attribute_name: Ouch! '$BOLD%s$NORMAL$RED' has not been configured as $BOLD%s$NORMAL$RED in %s scope. It's '%s' a git repository?${NORMAL}\n" "$value" "$attribute" "$scope" "$(pwd)" 1>&2
    else
        printf "${GREEN}Great! '$BOLD%s$NORMAL$GREEN' has been configured as $BOLD%s$NORMAL$GREEN in %s scope ${NORMAL}\n" "$(get_git_attribute $attribute $scope)" "$attribute" "$scope";
    fi
}
