
function import {
  local -r file="$1"
  shift

  source "$SANDBIN_HOME/$file" "$@"
}

# contains(string, substring)
#
# Returns 0 if the specified string contains the specified substring,
# otherwise returns 1.
#
# From: http://stackoverflow.com/a/8811800
#
function contains() {
    local string="$1"
    local substring="$2"

    return $(test "${string#*$substring}" != "$string")
}
