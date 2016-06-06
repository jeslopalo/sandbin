import "scripts/lib/usage.lib.zsh"
import "scripts/lib/output.lib.zsh"

import "scripts/dotfile/lib/dotfile.lib.zsh"

function usage_list() {
    local mode=$(usage_mode $1)
    local color=$(usage_description_color $mode $2)

    $(usage_show_description $mode) && printf "${color}List all available dotfile templates${NORMAL}\n"
    $(usage_show_usage $mode) && printf "usage: ${BOLD}dotfile list${NORMAL} [<dotfiles group>] [-h, --help]\n"

    if usage_show_detailed $mode; then
        printf "\n"
        printf "    ${BOLD}<dotfiles group>${NORMAL}        A dotfile group name (Optional)\n"
        printf "\nOptions:\n"
        printf "    ${BOLD}-h, --help${NORMAL}              Display this help\n"
    fi
}

function dotfile_list() {

    while [[ $# -gt 0 ]]; do
        key="$1"

        case $key in
            -h|--help)
                usage_list "help"
                exit 0
            ;;
            *)
                local group="$key"
            ;;
        esac
        shift
    done

    dotfiles=$(available_dotfiles "$group")
    if [ $? = 1 ]; then
        usage_list
        exit 1
    fi

    format_dotfile_list "$dotfiles"
    exit $?
}

function format_dotfile_list() {
    local dotfiles="$1"

    echo $dotfiles | while read dotfile; do
        printf "   - %s\n" $dotfile
    done
}
