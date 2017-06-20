import "scripts/lib/usage.lib.zsh"
import "scripts/lib/output.lib.zsh"

import "scripts/yaml/lib/yaml.lib.zsh"

function usage_extract() {
    local mode=$(usage_mode $1)
    local color=$(usage_description_color $mode $2)

    $(usage_show_description $mode) && printf "${color}Extract all variable values from a yaml input file${NORMAL}\n"
    $(usage_show_usage $mode) && printf "usage: ${BOLD}yaml extract${NORMAL} <yaml file> [-s, --separator <separator>] [-p, --prefix <prefix>] [-ul] [-h, --help]\n"

    if usage_show_detailed $mode; then
        printf "\n"
        printf "    ${BOLD}<yaml file>${NORMAL}        A YAML file to be processed\n"
        printf "\nOptions:\n"
        printf "    ${BOLD}-l, --lower${NORMAL}                     Add a lowercased var name to extracted vars\n"
        printf "    ${BOLD}-u, --upper${NORMAL}                     Add a uppercased var name to extracted vars\n"
        printf "    ${BOLD}-s, --separator <separator>${NORMAL}     Separator to apply to var names ('.' by default)\n"
        printf "    ${BOLD}-p, --prefix <prefix>${NORMAL}           Prefix to apply to var names\n"
        printf "    ${BOLD}-h, --help${NORMAL}                      Display this help\n"
    fi
}

function yaml_extract {
    local prefix=""

    while [[ $# -gt 0 ]]; do
        key="$1"

        case $key in
            -s|--separator)
                shift
                separator="$1"
            ;;
            -p|--prefix)
                shift
                prefix="$1"
            ;;
            -u|--upper|-lu|-ul)
                upper=1
            ;;
            -l|--lower|-lu|-ul)
                lower=1
            ;;
            -h|--help)
                usage_extract "help"
                exit 0
            ;;
            *)
                yaml_file=$key
            ;;
        esac
        shift
    done

    if [ -z $yaml_file ]; then
        printf "${RED}yaml: Sorry! I need a yaml file to continue :(${NORMAL}\n" 1>&2
        usage_extract
        exit 1
    elif [ ! -f $yaml_file ]; then
        printf "${RED}yaml extract: Ouch! Unknown file '%s'. Please try agan!${NORMAL}\n" "$yaml_file" 1>&2
        usage_extract
        exit 1
    fi

    extract "$yaml_file" "$prefix" "${separator:-.}" ${lower:-0} ${upper:-0}
    exit $?
}
