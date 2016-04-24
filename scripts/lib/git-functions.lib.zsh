source "${SANDBIN_HOME}/scripts/lib/colors.lib.zsh"

function new_alias() {
    local scope="$1"
    local alias_name="$2"
    local alias_command="$3"

    if [ $# = 3 ]; then
        printf "New command: ${YELLOW}git ${BOLD}%s${NORMAL}\n" "${alias_name}"
        git config $scope alias.${alias_name} "${alias_command}"
        return $?;
    else
        printf "New alias: scope, name or command not found\n"
        return 1;
    fi
}

function set_git_attribute() {
    local attribute="$1"
    local scope="$2"
    local value="$3"

    if [ $# = 3 ]; then
        git config $scope $attribute "$value"
        return $?;
    else
        printf "${RED}set_git_attribute: scope or '%s' not found${NORMAL}\n" "$attribute"
        return 1;
    fi
}

function get_git_attribute() {
    local attribute="$1"
    local scope="$2"

    git config $scope --get $attribute
}

function git_flow_init() {
    local force="$1"

    if [ -d "./.git" ]; then
        printf "Initializing git flow in '%s' directory...\n" "$(pwd)"
        git flow init $force
        exit $?
    else
        printf "Sorry! I need a git repository to work :(\n"
        exit 1
    fi
}

function git_tags() {
    git for-each-ref --sort=-taggerdate --format='%(refname:short)' refs/tags | sed 's/\\n/ /g'
}

function git_previous_tag_from_tag() {
    local tag="$1"

    git describe --abbrev=0 --tags $tag^ 2> /dev/null
}

function git_branch_name() {
    git branch-name
}

function git_tag_commit_id() {
    local tag="$1"

    git rev-list -n 1 $tag
}

function git_last_tag_id() {
    git last-tag-id
}

function git_last_tag_subject() {
    git last-tag-subject
}

function git_distance_from_last_tag() {
    git distance-from-tag $(git last-tag-id)
}

function git_exists_tag() {
    local tag="$1"
    git show-ref --tags --quiet --verify -- "refs/tags/$tag"
    return $?
}

#
# @parameters
#   - $from - starting ref (if not set, it will be the reference to the last tag or first commit)
#   - $to - ending ref (if not set, it will be HEAD)
#
function git_changelog_by_ref_range() {
    local from="$1"
    local to="$2"

    if [ -z $from ]; then
        from="$(git last-tag-id)"

        if [ -z $from ]; then
            from="$(git first-commit-id)";
        fi
    fi

    if [ "$to" = "" ]; then
        to="$(git last-commit-id)"
    fi

    to=$(git_tag_commit_id $to);
    from=$(git_tag_commit_id $from);

    if [ $from = $to ]; then
        git log $from --pretty='format:  %C(bold)*%Creset [%C(green)%h%Creset] %s' --reverse --no-merges;
    else
        git log $from..$to --pretty='format:  %C(bold)*%Creset [%C(green)%h%Creset] %s' --reverse --no-merges;
    fi
}