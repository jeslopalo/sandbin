
function new_alias() {
  local alias_name=$1
  local alias_command=$2

  printf "%s\n" "New command: ${YELLOW}git ${BOLD}${alias_name}${NORMAL}"
  git config $scope alias.${alias_name} "${alias_command}"
}

