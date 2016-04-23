source "${SANDBIN_HOME}/scripts/lib/colors.lib.zsh"
source "${SANDBIN_HOME}/scripts/lib/git-functions.lib.zsh"

function usage-ranking() {
    printf "'${YELLOW}gitbox ranking${NORMAL}' prints the github committers rank for a user\n"
    printf "${YELLOW}%s${NORMAL}\n" "usage: gitbox ranking [--madrid | --spain | -h, --help] <username>"
}

function gitbox-ranking() {

    while [[ $# > 0 ]]; do
        key="$1"

        case $key in
            --madrid)
                shift
                git_ranking_by_madrid "$@"
                exit $?
            ;;
            --spain)
                shift
                git_ranking_by_spain "$@";
                exit $?
            ;;
            -h|--help)
                usage-ranking
                exit 0
            ;;
            *)
                printf "${RED}Ouch! Unknown option '$key'. Please try agan!${NORMAL}\n"
                usage-ranking
                exit 1
            ;;
        esac

        shift;
    done

    printf "${RED}%s${NORMAL}\n" "Ouch! There is not enough parameters!"
    usage-ranking
    exit 1
}

git_ranking () {
    local url="$1"
    local username="$2"
    local location="$3"

    if [ -z $username ]; then
        printf "${RED}Sorry, I need to know your username to proceed${NORMAL}\n"
    else
        content=$(wget --no-check-certificate $url -q -O -)
        from_date=$(echo $content | grep "\*\*" | cut -d '*' -f 3)
        to_date=$(echo $content | grep "\*\*" | cut -d '*' -f 7)
        position=$(echo $content | grep "\[$username\]" | cut -d '|' -f 2 | cut -d ' ' -f 2)

        if [ "$position" = "" ]; then
            printf "${RED}Ouch! I can't find ${BOLD}%s$NORMAL$RED in the ranking of $BOLD%s${NORMAL}\n" "$username" "$location"
        else
            printf "(${YELLOW}%s${NORMAL} - ${YELLOW}%s${NORMAL}): ${BOLD}%s${NORMAL} has been the ${GREEN}%s${NORMAL}th committer in ${GREEN}%s${NORMAL}\n" \
            "$from_date" "$to_date" "$username" "$position" "$location"
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