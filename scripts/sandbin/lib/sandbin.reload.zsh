import "scripts/sandbin/lib/sandbin.lib.zsh"

function sandbin_reload() {
    if [ -z "$SHELL" ]; then
        exec $SHELL;
    fi

    import "sandbinrc"

    print_graph $(random_graph_name) "${CYAN}"

    printf "${WHITE}Hooray! your sandbin session has been reloaded!${NORMAL}\n"
}

