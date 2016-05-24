function usage_mode() {
    local mode="$1"

    echo $mode;
}

function usage_description_color() {
    local mode="$1"
    local color="$2"

    [ -z "$color" ] && [ "$mode" != "description" ] && echo "${CYAN}" || echo "$color"
}

function usage_show_description() {
    local mode="$1"

    [ "$mode" = "help" ] || [ "$mode" = "description" ]
    return $?
}

function usage_show_usage() {
    local mode="$1"

    [ "$mode" != "description" ]
    return $?
}

function usage_show_detailed() {
    local mode="$1"

    [ "$mode" = "help" ]
    return $?
}
