
function new_alias() {
    local scope="$1"
    local alias_name="$2"
    local alias_command="$3"

    if [ $# = 3 ]; then
        printf "%s\n" "New command: ${YELLOW}git ${BOLD}${alias_name}${NORMAL}"
        git config $scope alias.${alias_name} "${alias_command}"
        exit 1
    else
        printf "%s\n" "New alias: scope, name or command not found"
        exit 0
    fi
}

function set_git_username() {
    local scope="$1"
    local username="$2"

    if [ $# = 2 ]; then
        git config $scope user.name "$username"
    else
        printf "${RED}%s${NORMAL}\n" "set_git_username: scope or username not found"
    fi
}

function get_git_username() {
    local scope="$1"

    git config $scope --get user.name
}