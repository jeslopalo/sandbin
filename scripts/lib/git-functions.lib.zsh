
function new_alias() {
    local scope="$1"
    local alias_name="$2"
    local alias_command="$3"

    if [ $# = 3 ]; then
        printf "%s\n" "New command: ${YELLOW}git ${BOLD}${alias_name}${NORMAL}"
        git config $scope alias.${alias_name} "${alias_command}"
    else
        printf "%s\n" "New alias: scope, name or command not found"
    fi
}

function set_git_attribute() {
    local attribute="$1"
    local scope="$2"
    local value="$3"

    if [ $# = 3 ]; then
        git config $scope $attribute "$value"
    else
        printf "${RED}%s${NORMAL}\n" "set_git_attribute: scope or $attribute not found"
    fi
}

function get_git_attribute() {
    local attribute="$1"
    local scope="$2"

    git config $scope --get $attribute
}