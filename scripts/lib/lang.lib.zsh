
function import {
  local -r file="$1"
  shift
  # shellcheck source=$file
  source "$SANDBIN_HOME/$file" "$@"
}
