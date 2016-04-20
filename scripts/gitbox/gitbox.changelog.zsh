source "${SANDBIN_HOME}/scripts/lib/colors.lib.zsh"
source "${SANDBIN_HOME}/scripts/lib/git-functions.lib.zsh"

function usage-changelog() {
    printf "'${YELLOW}gitbox changelog${NORMAL}' updates changelog information\n"
    printf "${YELLOW}%s${NORMAL}\n" "usage: gitbox changelog [ -t, --tag <tagname> | -c, --current [-s, --subject <message>] | -h, --help]"
}

function gitbox-changelog() {

    while [[ $# > 0 ]]; do
        key="$1"

        case $key in
            -t|--tag)
                shift
                git_changelog_by_tag "$@" | less -FRX
                exit $?
            ;;
#            -s|--subject)
#                if [ $# -lt 2 ]; then
#                    printf "${RED}%s${NORMAL}\n" "Ouch! Do you forget something, don't you? I need a subject message!"
#                    usage-changelog
#                    exit 1
#                fi
#                subject="$2"
#                shift
#            ;;
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

    if contains_not_released_commits; then
        print_changelog_header_by_branch "$subject"
        printf "%s\n" "$(git_changelog_by_ref_range)"
        return $?
    else
        printf "${RED}%s${NORMAL}\n" "Sorry! There aren't commits yet since the last tag"
    fi

    exit 0
}

#
# @parameteres
#   - $tag - tag to calculate changelog
#
function git_changelog_by_tag() {

    if [ $# -lt 1 ]; then
        printf "${RED}%s${NORMAL}\n" "Ouch! Do you forget something, don't you? I need a tag name!"
        usage-changelog
        return 1
    fi

    local tag="$1"
    local previous_tag=$(git_previous_tag_from_tag $tag)

    git_exists_tag $tag;

    if ! git_exists_tag $tag; then
        printf "${RED}Sorry but '%s' tag does not exist!${NORMAL}\n" $tag
        return 1
    fi

    if [ -z $previous_tag ]; then
        print_changelog_header "v$tag - $(git tag-subject $tag)"
        git_changelog_by_ref_range $(git first-commit-id) $tag
    else
        print_changelog_header "v$tag - $(git tag-subject $tag)"
        git_changelog_by_ref_range $previous_tag $tag
    fi
}


function contains_not_released_commits() {

    if [ "$(git last-tag-id)" != "" ] && [ $(git_distance_from_last_tag) = 0 ]; then
        return 1
    else
        return 0
    fi
}

function print_changelog_header() {
    local subject="$1"

    if [ -z $subject ]; then
        printf "CHANGELOG\n"
    else
        printf "%s\n" "$subject"
    fi
    printf "-----------------------------------------------------------------------\n"
}

function print_changelog_header_by_branch() {
    local subject="$1"

    branch_name=$(git_branch_name)
    case $branch_name in
        feature/*)
            print_changelog_header "WIP(${branch_name##feature/})"
        ;;
        release/*)
            print_changelog_header "v${branch_name##release/} - $subject"
        ;;
        develop)
            print_changelog_header "WIP(develop)"
        ;;
        master)
            print_changelog_header "v$tag - $(git_last_tag_subject)"
        ;;
    esac

}