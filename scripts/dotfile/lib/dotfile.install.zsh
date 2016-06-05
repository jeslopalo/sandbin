import "scripts/lib/usage.lib.zsh"
import "scripts/lib/output.lib.zsh"

import "scripts/dotfile/lib/dotfile.lib.zsh"

function usage_install() {
    local mode=$(usage_mode $1)
    local color=$(usage_description_color $mode $2)

    $(usage_show_description $mode) && printf "${color}Install a dotfile template${NORMAL}\n"
    $(usage_show_usage $mode) && printf "usage: ${BOLD}dotfile install${NORMAL} <dotfile template> [-h, --help]\n"

    if usage_show_detailed $mode; then
        printf "\n"
        printf "    ${BOLD}<dotfile template>${NORMAL}      A dotfile template name to be installed\n"
        printf "\nOptions:\n"
        printf "    ${BOLD}--to-dir <directory>${NORMAL}    Target directory to install dotfile\n"
        printf "    ${BOLD}-h, --help${NORMAL}              Display this help\n"
    fi
}

function dotfile_install() {

    while [[ $# -gt 0 ]]; do
        key="$1"

        case $key in
            --to-dir)
                if [ ! -d "$2" ]; then
                    printf "${RED}dotfile install: Ouch! '%s' doesn't seem to be a valid directory.${NORMAL}\n" "$2" 1>&2
                    usage_install
                    exit 1
                fi
                directory="$2"
                shift
            ;;
            -h|--help)
                usage_install "help"
                exit 0
            ;;
            *)
                if [ -z "$name" ]; then
                    local name="$key"
                else
                    printf "${RED}%s${NORMAL}\n" "Ouch! Unknown option '$key'. Please try agan!" 1>&2
                    usage_install
                    exit 1
                fi
            ;;
        esac
        shift
    done

    if [ -z "$directory" ]; then
        directory=~
    fi

    if [ -z $name ]; then
        printf "${RED}dotfile install: Ouch! Do you forget something, don't you? I need a dotfile name!${NORMAL}\n" 1>&2
        usage_install
        exit 1
    fi

    install_dotfile "$name" "$directory"
    exit $?
}
