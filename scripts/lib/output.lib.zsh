
function say() {
    printf "${GREEN}%s${NORMAL}\n" "$1"
}

function ellipsis() {
    local length="$1"
    local line="$2"

    echo "$line" | awk -v len="$length" '{ if (length($0) > len) print substr($0, 1, len-3) "..."; else print; }'
}