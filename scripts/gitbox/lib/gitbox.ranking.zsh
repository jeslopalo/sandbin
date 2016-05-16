source "${SANDBIN_HOME}/scripts/lib/colors.lib.zsh"
source "${SANDBIN_HOME}/scripts/lib/usage.lib.zsh"
source "${SANDBIN_HOME}/scripts/lib/git-functions.lib.zsh"

function usage_ranking() {
    local mode=$(usage_mode $1)
    local color=$(usage_description_color $mode $2)

    $(usage_show_description $mode) && printf "${color}Display the position of a username in the Github committers rank${NORMAL}\n"
    $(usage_show_usage $mode) && printf "usage: ${BOLD}gitbox ranking${NORMAL} [--madrid] [--spain] <username> [-h, --help]\n"

    if usage_show_detailed $mode; then
        printf "\n"
        printf "    ${BOLD}<username>${NORMAL}      A Github username to search in ranking\n"
        printf "\nOptions:\n"
        printf "    ${BOLD}--madrid${NORMAL}        Search <username> in the ranking of Madrid (defaults to all)\n"
        printf "    ${BOLD}--spain${NORMAL}         Search <username> in the ranking of Spain (defaults to all)\n"
        printf "    ${BOLD}--alt-spain${NORMAL}     Search <username> in the alternative ranking of Spain (defaults to all)\n"
        printf "    ${BOLD}-h, --help${NORMAL}      Display this help\n"
    fi
}

function gitbox_ranking() {

    local locations;
    local username;

    while [[ $# > 0 ]]; do
        key="$1"

        case $key in
            --madrid)
                locations="madrid $locations"
            ;;
            --spain)
                locations="spain $locations"
            ;;
            --alt-spain)
                locations="alt $locations"
            ;;
            -h|--help)
                usage_ranking "help"
                exit 0
            ;;
            *)
                username="$1"
            ;;
        esac

        shift;
    done

    if [ "$locations" = "" ]; then
        locations="madrid spain alt"
    fi

    if [ "$username" = "" ]; then
        printf "${RED}gitbox ranking: Ouch! There is not enough parameters!, I need a username.${NORMAL}\n" 1>&2
        usage_ranking
        exit 1
    fi

    if [ "${locations/alt/}" != "${locations}" ]; then
        git_ranking_by_alt_spain "$username"
    fi

    if [ "${locations/spain/}" != "${locations}" ]; then
        git_ranking_by_spain "$username"
    fi

    if [ "${locations/madrid/}" != "${locations}" ]; then
        git_ranking_by_madrid "$username"
    fi

    exit $?
}

git_ranking () {
    local url="$1"
    local username="$2"
    local location="$3"

    if [ -z $username ]; then
        printf "${RED}gitbox ranking: Sorry, I need to know your username to proceed${NORMAL}\n" 1>&2
        usage_ranking
    else
        content=$(wget --no-check-certificate $url -q -O -)
        from_date=$(echo $content | grep "\*\*" | cut -d '*' -f 3)
        to_date=$(echo $content | grep "\*\*" | cut -d '*' -f 7)
        position=$(echo $content | grep "\[$username\]" | cut -d '|' -f 2 | cut -d ' ' -f 2)
        contributions=$(echo $content | grep "\[$username\]" | cut -d '|' -f 4 | sed 's/ //g')

        if [ "$position" = "" ]; then
            printf "${RED}gitbox ranking: Ouch! I can't find ${BOLD}%s$NORMAL$RED in the ranking of $BOLD%s${NORMAL}\n" "$username" "$location" 1>&2
        else
            printf "(${YELLOW}%s${NORMAL} - ${YELLOW}%s${NORMAL}): ${BOLD}%s${NORMAL} has been the ${GREEN}%s${NORMAL}th committer in ${GREEN}%s${NORMAL} with ${BOLD}%s${NORMAL} contributions\n" \
            "$from_date" "$to_date" "$username" "$position" "$location" "$contributions"
        fi
    fi
}

git_ranking_by_madrid() {
    local url="https://raw.githubusercontent.com/JJ/top-github-users-data/master/formatted/top-Madrid.md"
    local username="$1"
    local location="Madrid"

    git_ranking "$url" "$username" "$location"
}

git_ranking_by_spain() {
    local url="https://raw.githubusercontent.com/JJ/top-github-users-data/master/formatted/top-Espa%C3%B1a.md"
    local username="$1"
    local location="Spain"

    git_ranking "$url" "$username" "$location"
}

git_ranking_by_alt_spain() {
    local url="https://raw.githubusercontent.com/JJ/top-github-users-data/master/formatted/top-alt-Spain.md"
    local username="$1"
    local location="Spain (alt)"

    git_ranking "$url" "$username" "$location"
}
