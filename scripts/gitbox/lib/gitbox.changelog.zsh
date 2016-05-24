source "${SANDBIN_HOME}/scripts/lib/colors.lib.zsh"
source "${SANDBIN_HOME}/scripts/lib/usage.lib.zsh"
source "${SANDBIN_HOME}/scripts/lib/output.lib.zsh"
source "${SANDBIN_HOME}/scripts/lib/git-functions.lib.zsh"

function usage_changelog() {
    local mode=$(usage_mode $1)
    local color=$(usage_description_color $mode $2)

    $(usage_show_description $mode) && printf "${color}Generate changelog information${NORMAL}\n"
    $(usage_show_usage $mode) && printf "usage: ${BOLD}gitbox changelog${NORMAL} [ -t, --tag <tagname> | --all | --publish <release message>] [-h, --help]\n"

    if usage_show_detailed $mode; then
        printf "\nOptions:\n"
        printf "    ${BOLD}--all${NORMAL}                               %s\n" "Generate a complete changelog for every tag"
        printf "    ${BOLD}--publish <release message>${NORMAL}         %s\n" "$(usage_changelog_publish description)"
        printf "    ${BOLD}-t, --tag <tagname>${NORMAL}                 %s\n" "Generate changelog information for a tag"
        printf "    ${BOLD}-h, --help${NORMAL}                          %s\n" "Display this help"
    fi
}

function usage_changelog_publish() {
    local mode=$(usage_mode $1)
    local color=$(usage_description_color $mode $2)

    $(usage_show_description $mode) && printf "${color}Generate and commit a complete changelog to a git repository. Only works in hotfix or release branches.${NORMAL}\n"
    $(usage_show_usage $mode) && printf "usage: ${BOLD}gitbox changelog --publish${NORMAL} <release message> [--to-file <filename>] [--no-commit] [-h, --help]\n"

    if usage_show_detailed $mode; then
        printf "\n"
        printf "    <release message>           %s\n" "Release message for the next version"
        printf "\nOptions:\n"
        printf "    ${BOLD}--to-file <filename>${NORMAL}        %s\n" "Write changelog to <filename> file. It defaults to CHANGELOG.md or CHANGELOG"
        printf "    ${BOLD}--no-commit${NORMAL}                 %s\n" "Doesn't commit changes in the changelog file"
        printf "    ${BOLD}-h, --help${NORMAL}                  %s\n" "Display this help"
    fi
}

function gitbox_changelog() {

    if ! is_a_git_workspace; then
        printf "${RED}gitbox changelog: Sorry but the '%s' directory is not a git repository!${NORMAL}\n" $(pwd) 1>&2
        usage_changelog
        exit 1
    fi

    while [[ $# -gt 0 ]]; do
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
            --publish)
                shift
                git_changelog_publish "$@"
                exit $?
            ;;
            -h|--help)
                usage_changelog "help"
                exit 0
            ;;
            *)
                printf "${RED}gitbox changelog: Ouch! Unknown option '$key'. Please try agan!${NORMAL}\n" 1>&2
                usage_changelog
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
        printf "%s\n\n" "$(git_changelog_by_ref_range)"
        return $?
    else
        if [ "$release_message" != "" ]; then
            print_changelog_header_by_branch "$release_message"
        else
            printf "${RED}git changelog: There aren't commits yet since the last tag${NORMAL}\n" 1>&2
        fi
        return 1
    fi
}

#
# @parameteres
#   - $tag - tag to calculate changelog
#
function git_changelog_by_tag() {

    while [[ $# -gt 0 ]]; do
        key="$1"

        case $key in
            -h|--help)
                usage_changelog "help"
                exit 0
            ;;
            *)
                local tag="$key"
            ;;
        esac
        shift
    done

    if [ -z "$tag" ]; then
        printf "${RED}gitbox changelog tag: Ouch! Do you forget something, don't you? I need a tag name!${NORMAL}\n" 1>&2
        usage_changelog
        return 1
    fi

    if ! git_exists_tag $tag; then
        printf "${RED}gitbox changelog tag: Sorry but '%s' tag does not exist!${NORMAL}\n" "$tag" 1>&2
        usage_changelog
        return 1
    fi

    local previous_tag=$(git_previous_tag_from_tag $tag)
    if [ -z "$previous_tag" ]; then
        print_changelog_header "$(generate_tag_header $tag)"
        git_changelog_by_ref_range $(git_first_commit_id) $tag
    else
        print_changelog_header "$(generate_tag_header $tag)"
        git_changelog_by_ref_range $previous_tag $tag
    fi
    printf "\n\n"
}

function git_changelog_by_tag_range() {
    local tag="$1"
    local start_tag="$2"

    if ! git_exists_tag $start_tag; then
        printf "${RED}gitbox changelog: Sorry but '%s' tag does not exist!${NORMAL}\n" "$start_tag" 1>&2
        usage_changelog
        return 1
    fi

    if ! git_exists_tag $tag; then
        printf "${RED}gitbox changelog: Sorry but '%s' tag does not exist!${NORMAL}\n" "$tag" 1>&2
        usage_changelog
        return 1
    fi

    if [ -z "$start_tag" ]; then
        print_changelog_header "$(generate_tag_header $tag)"
        git_changelog_by_ref_range $(git_first_commit_id) $tag
    else
        print_changelog_header "$(generate_tag_header $tag)"
        git_changelog_by_ref_range $start_tag $tag
    fi
}

function generate_tag_header() {
    local tag="$1"
    local subject="$(git_tag_subject $tag | sed "s/^v*$tag//" | sed 's/^[ \:-]*//')"
    local date="$(git_tag_date $tag)"

    ellipsis 128 "v$tag ($date) - $subject"
}

#
# @parameters
#   - $release_message - Message to include in the most recents changes in changelog
#
function git_changelog_publish() {

    while [[ $# -gt 0 ]]; do
        key="$1"

        case $key in
            --to-file)
                if [ $# -lt 2 ]; then
                    printf "${RED}gitbox changelog publish: I need a filename! Maybe the next time?${NORMAL}\n\n" 1>&2
                    usage_changelog_publish
                    exit 1
                fi
                shift
                filename="$1"
            ;;
            --no-commit)
                no_commit=true
            ;;
            -h|--help)
                usage_changelog_publish "help"
                exit 0
            ;;
            *)
                if [ "$(echo $1 | grep -v '^--')" = "" ]; then
                    printf "${RED}gitbox changelog publish: Ouch! Unknown option '%s'. Please try agan!${NORMAL}\n" "$1" 1>&2
                    usage_changelog_publish
                    exit 1
                fi
                release_message="$1"
            ;;
        esac
        shift
    done

    version=$(git_branch_version)
    if [ "$version" = "WIP" ]; then
        printf "${RED}gitbox changelog publish: Sorry! I need a release branch to work (a hotfix branch is also good)!${NORMAL}\n" 1>&2
        usage_changelog_publish
        return 1
    fi

    if [ -z "$release_message" ]; then
        printf "${RED}gitbox changelog publish: Ouch! Do you forget something, don't you? I need a release message!${NORMAL}\n" 1>&2
        usage_changelog_publish
        return 1
    fi

    if [ -z "$filename" ]; then
        if [ -f "CHANGELOG.md" ]; then
            filename="CHANGELOG.md"
        elif [ -f "CHANGELOG" ]; then
            filename="CHANGELOG"
        else
            filename="CHANGELOG.md"
        fi
    fi

    printf "Writing changes to ${BOLD}%s${NORMAL}\n" "$filename"
    print_changelog_all "$release_message" | strip_color_codes > $filename

    if [ -z "$no_commit" ]; then
        git add "$filename"
        git commit -m "Update $filename with $version changes"
    else
        printf "${YELLOW}${BOLD}--no-commit${NORMAL} ${YELLOW}is active, no changes will be commited${NORMAL}\n"
    fi

    printf "\n%s\n\n\n" "$(git_changelog_wip $release_message)"
    exit $?
}

#
# @parameters
#   - $release_message - Message to include in the most recents changes in changelog
#
function git_changelog_all() {

    while [[ $# -gt 0 ]]; do
        key="$1"

        case $key in
            -h|--help)
                usage_changelog "help"
                exit 0
            ;;
            *)
                printf "${RED}gitbox changelog all: Ouch! Unknown option '%s'. Please try agan!${NORMAL}\n" "$key" 1>&2
                usage_changelog
                exit 1
            ;;
        esac
        shift
    done

    print_changelog_all
    exit $?
}

function print_changelog_all() {
    local release_message="$1"

    if contains_not_released_commits; then
        printf "%s\n\n\n" "$(git_changelog_wip $release_message)"
    fi

    local starting_tag;
    local ending_tag;
    for ending_tag in $(git_tags); do
        if [ "$starting_tag" != "" ]; then
            printf "%s\n\n\n" "$(git_changelog_by_tag_range $starting_tag $ending_tag)"
        fi
        starting_tag=$ending_tag
    done

    if [ ! -z $starting_tag ]; then
        printf "%s\n\n\n" "$(git_changelog_by_tag $starting_tag)"
    fi
}

function contains_not_released_commits() {

    if [ "$(git_last_tag_id)" != "" ] && [ $(git_distance_from_last_tag) = 0 ]; then
        return 1
    else
        return 0
    fi
}

function print_changelog_header() {
    local release_message="$1"

    if [ -z "$release_message" ]; then
        printf "### CHANGELOG\n\n"
    else
        printf "### %s\n\n" "$release_message"
    fi
}

function print_changelog_header_by_branch() {
    local release_message="$1"
    local today="$(date +%F)"

    branch_name=$(git_branch_name)
    case $branch_name in
        feature/* | develop | master)
            if [ -z "$release_message" ]; then
                print_changelog_header "WIP(branch:${branch_name##feature/})"
            else
                print_changelog_header "WIP(branch:${branch_name##feature/}) - $release_message"
            fi
        ;;
        release/*)
            if [ -z "$release_message" ]; then
                print_changelog_header "v${branch_name##release/} ($today)"
            else
                print_changelog_header "v${branch_name##release/} ($today) - $release_message"
            fi
        ;;
        hotfix/*)
            if [ -z "$release_message" ]; then
                print_changelog_header "v${branch_name##hotfix/} ($today)"
            else
                print_changelog_header "v${branch_name##hotfix/} ($today) - $release_message"
            fi
        ;;
    esac
}
