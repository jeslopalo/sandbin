import "scripts/lib/usage.lib.zsh"
import "scripts/lib/git-functions.lib.zsh"

import "scripts/bump/lib/bump.lib.zsh"

function usage_bump_version() {
    local system=$(version_system "$1")
    local file=$(version_file "$system")

    local mode=$(usage_mode $2)
    local color=$(usage_description_color $mode $3)

    $(usage_show_description $mode) && printf "${color}Bump version in versionable files: ${BOLD}%s${NORMAL} ${color}file(s)${NORMAL}\n" "$file"
    $(usage_show_usage $mode) && printf "usage: ${BOLD}bump %s${NORMAL} <version> [--no-commit | -h, --help]\n" "$system"

    if usage_show_detailed $mode; then
        printf "\n"
        printf "    ${BOLD}<version>${NORMAL}          New version of the project (Optional. If not set, it will try to extract it from the name of the branch)\n"
        printf "\nOptions:\n"
        printf "    ${BOLD}--no-commit${NORMAL}        Doesn't commit changes in versionable file(s)\n"
        printf "    ${BOLD}-h, --help${NORMAL}         Display this help\n"
    fi
}

function bump_version() {
    local system=$(version_system "$1")
    local file=$(version_file "$system")

    # Skip the versionable system value
    [ $# -gt 0 ] && shift;

    local version
    while [[ $# -gt 0 ]]; do
        key="$1"

        case $key in
            --no-commit)
                no_commit=true
            ;;
            -h|--help)
                usage_bump_version "$system" "help"
                return 0
            ;;
            *)
                version="$1"
            ;;
        esac

        shift;
    done

    if ! $(is_versionable "$system"); then
        printf "${RED}bump %s: Sorry but the '%s' directory does not contain a versionable file (%s)!${NORMAL}\n" "$system" $(pwd) "$file" 1>&2
        usage_bump_version "$system"
        return 1
    fi

    if [ -z "$version" ]; then

        if ! is_a_git_workspace; then
            printf "${RED}bump %s: Sorry but the new version can't be automatically calculated!${NORMAL}\n" "$system" 1>&2
            usage_bump_version "$system"
            return 1
        fi

        version=$(extract_version_from_branch_name)
        if [ -z "$version" ]; then
            printf "${RED}bump %s: The new version can't be automatically calculated if you're not in a release branch!${NORMAL}\n" "$system" 1>&2
            usage_bump_version "$system"
            return 1
        fi
    fi

    set_version "$system" "$version"
    if [ $? = 0 ] && [ -z "$no_commit" ]; then
        commit_versionable_files "$system" "$version"
    else
        printf "${YELLOW}${BOLD}--no-commit${NORMAL} ${YELLOW}is active, no changes will be commited${NORMAL}\n"
    fi

    return $?
}
