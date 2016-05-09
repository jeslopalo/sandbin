function random_file_name() {
    local directory="$1"

    file_name=$(find $directory  -maxdepth 1 -type f | \
        perl -we'rand($.) < 1 && ($pick = $_) while <>; print $pick' | \
        xargs -n 1 -I {} basename {})

    echo ${file_name%.*}
}

function random_graph_name() {
    random_file_name "$SANDBIN_HOME/scripts/sandbin/assets/graphs/"
}

function random_banner_name() {
    random_file_name "$SANDBIN_HOME/scripts/sandbin/assets/banner/"
}

function print_acii_art() {
    local filename=$1
    local color=$2
    printf "\n${color}%s${NORMAL}\n\n" "$(cat ${filename})"
}

function print_banner() {
    print_acii_art "$SANDBIN_HOME/scripts/sandbin/assets/banner/${1}.txt" "$2"
}

function print_graph() {
    print_acii_art "$SANDBIN_HOME/scripts/sandbin/assets/graphs/${1}.txt" "$2"
}

function print_sandbin_banner() {
    local version=$1;
    local banner_color=$2;
    local banner_name=$([ $# -ge 3 ] && echo $3 || echo $(random_banner_name))

    if [ -z "$banner_color" ]; then
        banner_color="${GREEN}"
    fi

    print_banner ${banner_name} $banner_color

    if [ ! -z "$version" ]; then
        printf "${RED}%s${NORMAL}\n" "                                                           revision: $version"
    fi
}

sandbin_version() {
    cd "$SANDBIN_HOME"

    echo $(git for-each-ref refs/tags --sort=-taggerdate --format='%(refname:short)' --count=1)
}
