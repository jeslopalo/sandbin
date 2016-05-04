source "${SANDBIN_HOME}/scripts/lib/colors.lib.zsh"
source "${SANDBIN_HOME}/scripts/lib/output.lib.zsh"
source "${SANDBIN_HOME}/scripts/lib/git-functions.lib.zsh"

function usage-changelog() {
    printf "'${YELLOW}gitbox changelog${NORMAL}' updates changelog information\n"
    printf "${YELLOW}%s${NORMAL}\n" "usage: gitbox changelog [ -t, --tag <tagname> | --all | --publish <release message> | -h, --help]"
}

function usage-changelog-all() {
    printf "'${YELLOW}gitbox changelog --all${NORMAL}' generates a complete changelog for every tag\n"
    printf "${YELLOW}%s${NORMAL}\n" "usage: gitbox changelog --all [-h, --help]"
}

function usage-changelog-publish() {
    printf "'${YELLOW}gitbox changelog --publish${NORMAL}' write a complete changelog and commit to repository\n"
    printf "${YELLOW}%s${NORMAL}\n" "usage: gitbox changelog --publish <release message> [ --to-file <filename> | --no-commit | -h, --help]"
}

function gitbox-changelog() {

    if ! is_a_git_workspace; then
        printf "${RED}Sorry but the '%s' directory is not a git repository!${NORMAL}\n" $(pwd)
        exit 1
    fi

    while [[ $# > 0 ]]; do
        key="$1"

        case $key in
            -t|--tag)
                shift
                git_changelog_by_tag "$@" | less -FRX
                exit $?
            ;;
            --publish)
                shift
                git_changelog_publish "$@"
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
        printf "%s\n\n" "$(git_changelog_by_ref_range)"
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
        printf "${RED}Sorry but '%s' tag does not exist!${NORMAL}\n" "$start_tag"
        return 1
    fi

    if ! git_exists_tag $tag; then
        printf "${RED}Sorry but '%s' tag does not exist!${NORMAL}\n" "$tag"
        return 1
    fi

    if [ -z $start_tag ]; then
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

    while [[ $# > 0 ]]; do
        key="$1"

        case $key in
            --to-file)
                if [ $# -lt 2 ]; then
                    printf "${YELLOW}I need a filename! Maybe the next time?${NORMAL}\n\n"
                    usage-changelog-publish
                    exit 1
                fi
                shift
                filename="$1"
            ;;
            --no-commit)
                no_commit=true
            ;;
            -h|--help)
                usage-changelog-publish
                exit 1
            ;;
            *)
                if [ "$(echo $1 | grep -v '^--')" = "" ]; then
                    printf "${RED}Ouch! Unknown option '%s'. Please try agan!${NORMAL}\n" "$1"
                    usage-changelog-all
                    exit 1
                fi
                release_message="$1"
            ;;
        esac
        shift
    done

    version=$(git_branch_version)
    if [ "$version" = "WIP" ]; then
        printf "${RED}Sorry! I need a release branch to work (a hotfix branch is also good)!${NORMAL}\n"
        usage-changelog-publish
        return 1
    fi

    if [ -z $release_message ]; then
        printf "${RED}Ouch! Do you forget something, don't you? I need a release message!${NORMAL}\n"
        usage-changelog-publish
        return 1
    fi

    if [ -z $filename ]; then
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

    if [ -z $no_commit ]; then
        git add "$filename"
        git commit -m "Update $filename with $version changes"
    else
        printf "${YELLOW}${BOLD}--no-commit${NORMAL} ${YELLOW}is active, no changes will be commited${NORMAL}\n"
    fi

    exit $?
}

#
# @parameters
#   - $release_message - Message to include in the most recents changes in changelog
#
function git_changelog_all() {

    while [[ $# > 0 ]]; do
        key="$1"

        case $key in
            -h|--help)
                usage-changelog-all
                exit 1
            ;;
            *)
                printf "${RED}Ouch! Unknown option '%s'. Please try agan!${NORMAL}\n" "$key"
                usage-changelog-all
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

    if [ -z $release_message ]; then
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
            if [ -z $release_message ]; then
                print_changelog_header "WIP(branch:${branch_name##feature/})"
            else
                print_changelog_header "WIP(branch:${branch_name##feature/}) - $release_message"
            fi
        ;;
        release/*)
            if [ -z $release_message ]; then
                print_changelog_header "v${branch_name##release/} ($today)"
            else
                print_changelog_header "v${branch_name##release/} ($today) - $release_message"
            fi
        ;;
        hotfix/*)
            if [ -z $release_message ]; then
                print_changelog_header "v${branch_name##hotfix/} ($today)"
            else
                print_changelog_header "v${branch_name##hotfix/} ($today) - $release_message"
            fi
        ;;
    esac
}