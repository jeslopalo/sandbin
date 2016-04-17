source "${SANDBIN_HOME}/scripts/lib/colors.lib.zsh"
source "${SANDBIN_HOME}/scripts/lib/git-functions.lib.zsh"

function usage-changelog() {
    printf "'${YELLOW}gitbox changelog${NORMAL}' updates changelog information\n"
    printf "${YELLOW}%s${NORMAL}\n" "usage: gitbox changelog [ -t, --tag <tagname> | -s, --subject <message> | -h, --help]"
}

function gitbox-changelog() {

    while [[ $# > 0 ]]; do
        key="$1"

        case $key in
            -t|--tag)

                if [ $# -lt 2 ]; then
                    printf "${RED}%s${NORMAL}\n" "Ouch! Do you forget something, don't you? I need a tag name!"
                    usage-changelog
                    exit 1
                fi
                tag="$2"
                shift
            ;;
            -s|--subject)

                if [ $# -lt 2 ]; then
                    printf "${RED}%s${NORMAL}\n" "Ouch! Do you forget something, don't you? I need a subject message!"
                    usage-changelog
                    exit 1
                fi
                subject="$2"
                shift
            ;;
            -h|--help)
                usage-changelog
                exit 0
            ;;
            *)
                printf "${RED}%s${NORMAL}\n" "Ouch! Unknown option '$key'. Please try agan!"
                usage-changelog
                exit 1
            ;;
        esac

        shift;
    done

    if [ ! -z $tag ]; then
        printf "%s\n" "$(git_changelog_by_tag $tag)"
    else

        if contains_not_released_commits; then
            print_changelog_head "$subject"
            printf "%s\n" "$(git_changelog_by_ref_range)"

        else
            printf "${RED}%s${NORMAL}\n" "Sorry! There aren't commits yet since the last tag"
        fi
    fi

    exit 0
}

function contains_not_released_commits() {

    if [ "$(git last-tag-id)" != "" ] && [ $(git_distance_from_last_tag) = 0 ]; then
        return 1
    else
        return 0
    fi
}

function print_changelog_head() {
    local subject="$1"

    branch_name=$(git_branch_name)
    case $branch_name in
        feature/*)
            printf "## WIP(%s)\n" "${branch_name##feature/}"
        ;;
        release/*)
            printf "## N%s - \n" "${branch_name##release/}" "$subject"
        ;;
        develop)
            printf "## WIP(%s)\n" "develop"
        ;;
        master)
            printf "## %s\n" "$(git_last_tag_subject)"
        ;;
    esac
}