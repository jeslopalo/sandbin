
function hash() {
    echo "$1" | /usr/bin/shasum | /usr/bin/cut -c 1-13 | xargs -n 1 -I {} echo {}
}

# When a source file is imported, it is also cached to be included only once
CACHED_IMPORTS=$(hash "scripts/lib/lang.lib.zsh")

function import {
    local -r file="$1"
    shift

    local hashed=$(hash "$file")
    if ! contains "$CACHED_IMPORTS" "$hashed"; then
        CACHED_IMPORTS="$CACHED_IMPORTS $hashed"
        source "$SANDBIN_HOME/$file" "$@"
    fi
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
