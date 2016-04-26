source "${SANDBIN_HOME}/scripts/lib/colors.lib.zsh"
source "${SANDBIN_HOME}/scripts/lib/git-functions.lib.zsh"

function usage-ranking() {
    printf "'${YELLOW}gitbox ranking${NORMAL}' prints the github committers rank for a user\n"
    printf "${YELLOW}%s${NORMAL}\n" "usage: gitbox ranking [--madrid | --spain | -h, --help] <username>"
}

function gitbox-ranking() {

    local locations;
    local username;

    while [[ $# > 0 ]]; do
        key="$1"

        case $key in
            --madrid)
                locations="madrid$locations"
            ;;
            --spain)
                locations="spain$locations"
            ;;
            -h|--help)
                usage-ranking
                exit 0
            ;;
            *)
                username="$1"
            ;;
        esac

        shift;
    done

    if [ "$locations" = "" ]; then
        printf "${RED}%s${NORMAL}\n" "Ouch! There is not enough parameters!, I need a location."
        usage-ranking
        exit 1
    fi

    if [ "$username" = "" ]; then
        printf "${RED}%s${NORMAL}\n" "Ouch! There is not enough parameters!, I need a username."
        usage-ranking
        exit 1
    fi

    if [ "${locations/spain/}" != "${locations}" ]; then
        git_ranking_by_spain "$username"
    fi

    if [ "${locations/madrid/}" != "${locations}" ]; then
        git_ranking_by_madrid "$username"
    fi

    exit 0
}

git_ranking () {
    local url="$1"
    local username="$2"
    local location="$3"

    if [ -z $username ]; then
        printf "${RED}Sorry, I need to know your username to proceed${NORMAL}\n"
        usage-ranking
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