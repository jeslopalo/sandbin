
function new_alias() {
    local scope=$1
    local alias_name=$2
    local alias_command=$3

    if [ $# = 2 ]; then
        printf "%s\n" "New command: ${YELLOW}git ${BOLD}${alias_name}${NORMAL}"
        git config $scope alias.${alias_name} "${alias_command}"
    else
        printf "%s\n" "New alias: name&/command not found"
    fi
}
