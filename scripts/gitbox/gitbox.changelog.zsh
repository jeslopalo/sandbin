source "${SANDBIN_HOME}/scripts/lib/colors.lib.zsh"
source "${SANDBIN_HOME}/scripts/lib/git-functions.lib.zsh"

function usage-changelog() {
    printf "'${YELLOW}gitbox changelog${NORMAL}' updates changelog information\n"
    printf "${YELLOW}%s${NORMAL}\n" "usage: gitbox changelog [-h, --header <message> | -h, --help]"
}

function gitbox-changelog() {

    while [[ $# > 0 ]]; do
        key="$1"

        case $key in

            -h|--header)
                message="$2"
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

    if [ $(git_distance_from_last_tag) = 0 ]; then
        printf "${RED}%s${NORMAL}\n" "Sorry! There aren't commits yet since the last tag"
    else
        print_changelog_head "$message"
        printf "%s\n\n" "$(git_changelog)"
    fi
}

function print_changelog_head() {
    local message="$1"

    branch_name=$(git_branch_name)
    case $branch_name in
        feature/*)
            printf "## WIP: %s %s\n" "${branch_name##feature/}" "$message"
        ;;
        release/*)
            printf "## %s - %s\n" "${branch_name##release/}" "$message"
        ;;
        develop)
            printf "## WIP: %s %s\n" "develop" "$message"
        ;;
        master)
            printf "## %s\n" "$(git_last_tag_subject)"
        ;;
    esac
}