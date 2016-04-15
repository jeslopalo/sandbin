
function new_alias() {
    local scope="$1"
    local alias_name="$2"
    local alias_command="$3"

    if [ $# = 3 ]; then
        printf "%s\n" "New command: ${YELLOW}git ${BOLD}${alias_name}${NORMAL}"
        git config $scope alias.${alias_name} "${alias_command}"
        return $?;
    else
        printf "%s\n" "New alias: scope, name or command not found"
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
        printf "${RED}%s${NORMAL}\n" "set_git_attribute: scope or $attribute not found"
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
        printf "Initializing git flow in '%s' directory...\n" $(pwd)
        git flow init $force
        exit $?
    else
        printf "Sorry! I need a git repository to work :("
        exit 1
    fi
}

function git_changelog() {
    git changelog
}

function git_branch_name() {
    git branch-name
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