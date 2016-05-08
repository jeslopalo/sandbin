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
        printf "New alias: scope, name or command not found\n" 1>&2
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
        printf "${RED}set_git_attribute: scope or '%s' not found${NORMAL}\n" "$attribute" 1>&2
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
        printf "Sorry! I need a git repository to work :(\n" 1>&2
        exit 1
    fi
}

function git_tags() {
    git for-each-ref --sort=-taggerdate --format='%(refname:short)' refs/tags | sed 's/\\n/ /g'
}

function git_tag_subject() {
    local tag="$1"
    git for-each-ref refs/tags/$tag --format='%(refname:short)#%(subject)' | cut -f 2 -d '#';
}

function git_tag_date() {
    local tag="$1"
    git for-each-ref refs/tags/$tag --format='%(refname:short)#%(taggerdate:short)' | cut -f 2 -d '#';
}

function git_previous_tag_from_tag() {
    local tag="$1"
    git describe --abbrev=0 --tags $tag^ 2> /dev/null
}

function git_branch_name() {
    git rev-parse --abbrev-ref HEAD
}

function git_branch_version() {

    branch_name=$(git_branch_name)
    case $branch_name in
        release/*)
            echo "${branch_name##release/}"
        ;;
        hotfix/*)
            echo "${branch_name##hotfix/}"
        ;;
        *)
            echo "WIP"
        ;;
    esac
}

function git_tag_commit_id() {
    local tag="$1"
    git rev-list -n 1 $tag
}

function git_last_tag_id() {
    git for-each-ref refs/tags --sort=-taggerdate --format='%(refname:short)' --count=1
}

function git_last_tag_subject() {
    git for-each-ref refs/tags --sort=-taggerdate --format='%(subject)' --count=1
}

function git_first_commit_id() {
    git rev-list --max-parents=0 HEAD
}

function git_last_commit_id() {
    git rev-parse --verify HEAD
}

function git_distance_from_last_tag() {
    git rev-list --count --no-merges $(git_last_tag_id)..HEAD;
}

function git_exists_tag() {
    local tag="$1"
    git show-ref --tags --quiet --verify -- "refs/tags/$tag"
}

#
# @parameters
#   - $directory - a directory to check for git workspace
#
function is_a_git_workspace() {
    local directory="$1"
    local current=$(pwd)

    if [ ! -z $directory ]; then
        cd "$directory"
    fi

    if [ -d .git ]; then
        cd $current;
        return 0
    elif [ "$(git rev-parse --git-dir 2> /dev/null)" != "" ]; then
        cd $current;
        return 0
    fi

    cd $current;
    return 1
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
        from="$(git_last_tag_id)"

        if [ -z $from ]; then
            from="$(git_first_commit_id)";
        fi
    fi

    if [ "$to" = "" ]; then
        to="$(git_last_commit_id)"
    fi

    to=$(git_tag_commit_id $to);
    from=$(git_tag_commit_id $from);

    if [ $from = $to ]; then
        git log $from --pretty='format:  %C(bold)*%Creset [%C(green)%h%Creset] %s' --reverse --no-merges;
    else
        git log $from..$to --pretty='format:  %C(bold)*%Creset [%C(green)%h%Creset] %s' --reverse --no-merges;
    fi
}