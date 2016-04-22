source "${SANDBIN_HOME}/scripts/lib/colors.lib.zsh"
source "${SANDBIN_HOME}/scripts/lib/git-functions.lib.zsh"

function usage-changelog() {
    printf "'${YELLOW}gitbox changelog${NORMAL}' updates changelog information\n"
    printf "${YELLOW}%s${NORMAL}\n" "usage: gitbox changelog [ -t, --tag <tagname> | --all <release message> | -h, --help]"
}

function usage-changelog-all() {
    printf "'${YELLOW}gitbox changelog --all${NORMAL}' generates a complete changelog for every tag\n"
    printf "${YELLOW}%s${NORMAL}\n" "usage: gitbox changelog --all <release message> [ --to-file <filename> | -h, --help]"
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

    git_changelog_wip "$release_message"
    exit $?
}

#
# @parameters
#   - $release_message - message to include in changelog header (optional)
#
function git_changelog_wip() {
    local release_message="$1"

    if contains_not_released_commits; then
        print_changelog_header_by_branch "$release_message"
        printf "%s\n" "$(git_changelog_by_ref_range)"
        return $?
    else
        if [ "$release_message" != "" ]; then
            print_changelog_header_by_branch "$release_message"
        else
            printf "${RED}There aren't commits yet since the last tag${NORMAL}\n"
        fi
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
        printf "%s" "$subject"
    elif [[ $subject = $tag* ]]; then
        printf "%s" "v$subject"
    else
        printf "v%s - %s" "$tag" "$subject"
    fi
}

#
# @parameters
#   - $release_message - Message to include in the most recents changes in changelog
#
function git_changelog_all() {
    while [[ $# > 0 ]]; do
        key="$1"

        case $key in
            --to-file)
                if [ $# -lt 2 ]; then
                    printf "${YELLOW}I need a filename! Maybe the next time?${NORMAL}\n\n"
                    usage-changelog-all
                    exit 1
                fi
                shift
                filename="$1"
            ;;
            -h|--help)
                usage-changelog-all
                exit 1
            ;;
            *)
                release_message="$1"
            ;;
        esac
        shift
    done

    if [ -z $release_message ]; then
        printf "${RED}Ouch! Do you forget something, don't you? I need a release message!${NORMAL}\n" ""
        usage-changelog-all
        return 1
    fi

    if [ -z $filename ]; then
        print_changelog_all "$release_message"
    else
        print_changelog_all "$release_message" | strip_color_codes > $filename
    fi
}

function print_changelog_all() {
    local release_message="$1"

    if contains_not_released_commits; then
        printf "%s\n\n" "$(git_changelog_wip $release_message)"
    fi

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
    local release_message="$1"

    if [ -z $release_message ]; then
        printf "CHANGELOG\n"
    else
        printf "%s\n" "$release_message"
    fi
    printf "------------------------------------------------------------------------------------------\n"
}

function print_changelog_header_by_branch() {
    local release_message="$1"

    branch_name=$(git_branch_name)
    case $branch_name in
        feature/* | develop | master)
            if [ -z $release_message ]; then
                print_changelog_header "WIP(branch:${branch_name##feature/})"
            else
                print_changelog_header "WIP(branch:${branch_name##feature/}) - $release_message"
            fi
        ;;
        release/*)
            if [ -z $release_message ]; then
                print_changelog_header "v${branch_name##release/}"
            else
                print_changelog_header "v${branch_name##release/} - $release_message"
            fi
        ;;
        master)
        ;;
    esac
}