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
            --all)
                shift
                git_changelog_all "$@";
                exit $?
            ;;
            -h|--help)
                usage-changelog
                exit 0
            ;;
            *)
                printf "${RED}Ouch! Unknown option '$key'. Please try agan!${NORMAL}\n"
                usage-changelog
                exit 1
            ;;
        esac

        shift;
    done

    git_changelog_wip "$subject"
    exit $?
}

#
# @parameters
#   - $subject - message to include in changelog header (optional)
#
function git_changelog_wip() {
    local subject="$1"

    if contains_not_released_commits; then
        print_changelog_header_by_branch "$subject"
        printf "%s\n" "$(git_changelog_by_ref_range)"
        return $?
    else
        if [ "$subject" != "" ]; then
            print_changelog_header_by_branch "$subject"
        fi
        printf "${RED}There aren't commits yet since the last tag${NORMAL}\n"
        return 1
    fi
}

#
# @parameteres
#   - $tag - tag to calculate changelog
#
function git_changelog_by_tag() {

    if [ $# -lt 1 ]; then
        printf "${RED}Ouch! Do you forget something, don't you? I need a tag name!${NORMAL}\n"
        usage-changelog
        return 1
    fi

    local tag="$1"
    if ! git_exists_tag $tag; then
        printf "${RED}Sorry but '%s' tag does not exist!${NORMAL}\n" "$tag"
        return 1
    fi

    local previous_tag=$(git_previous_tag_from_tag $tag)
    if [ -z $previous_tag ]; then
        print_changelog_header "$(generate_tag_header $tag)"
        git_changelog_by_ref_range $(git first-commit-id) $tag
    else
        print_changelog_header "$(generate_tag_header $tag)"
        git_changelog_by_ref_range $previous_tag $tag
    fi
}

function git_changelog_by_tag_range() {
    local tag="$1"
    local start_tag="$2"

    if ! git_exists_tag $start_tag; then
        printf "${RED}Sorry but '%s' tag does not exist!${NORMAL}\n" "$start_tag"
        return 1
    fi

    if ! git_exists_tag $tag; then
        printf "${RED}Sorry but '%s' tag does not exist!${NORMAL}\n" "$tag"
        return 1
    fi

    if [ -z $start_tag ]; then
        print_changelog_header "$(generate_tag_header $tag)"
        git_changelog_by_ref_range $(git first-commit-id) $tag
    else
        print_changelog_header "$(generate_tag_header $tag)"
        git_changelog_by_ref_range $start_tag $tag
    fi
}

function generate_tag_header() {
    local tag="$1"
    local subject="$(git tag-subject $1 | tr -d '\n' | awk -v len=80 '{ if (length($0) > len) print substr($0, 1, len-3) "..."; else print; }' )"

    if [[ $subject = v$tag* ]]; then
        echo "$subject"
    elif [[ $subject = $tag* ]]; then
        echo "v$subject"
    else
        echo "v$tag - $subject"
    fi
}

#
# @parameters
#   - $subject - Message to include in the most recents changes in changelog
#
function git_changelog_all() {
    local subject="$1"

    printf "%s\n\n" "$(git_changelog_wip \"$subject\")"
    local starting_tag;
    local ending_tag;
    for ending_tag in $(git_tags); do
        if [ "$starting_tag" != "" ]; then
            printf "%s\n\n" "$(git_changelog_by_tag_range $starting_tag $ending_tag)"
        fi
        starting_tag=$ending_tag
    done
    printf "%s\n\n" "$(git_changelog_by_tag $starting_tag)"
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
    printf "------------------------------------------------------------------------------------------\n"
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