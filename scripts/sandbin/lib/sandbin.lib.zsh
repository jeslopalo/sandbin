source "$SANDBIN_HOME/scripts/lib/moustache.lib.zsh"

function generate_sandbin_config_file() {
    local sandbin_home=$1;
    local sandbin_template="$sandbin_home/dotfiles/sandbin/sandbin.conf.template"
    local sandbin_config="$sandbin_home/sandbin.conf"

    if [ ! -f "$sandbin_config" ]; then
        printf "Copying sandbin.conf file to '%s'...\n" "$sandbin_home"
        cp "$sandbin_template" "$sandbin_config"

        replace "sandbinhome" "$sandbin_home" "$sandbin_config"
    fi
}

function remove_between_marks_in_file() {
    local start_mark="$1";
    local end_mark="$2";
    local file="$3";

    # Remove from content
    sed "/$start_mark/,/$end_mark/d" "$file" > "$file.tmp"

    # Backup old file before rewrite
    /bin/cp "$file" "$file.oldbackup"
    /bin/mv "$file.tmp" "$file"
}

function configure_sandbin_bootstrap() {
    local config_file=$1;
    local sandbin_home=$2;
    local sandbin_home_sha=`echo $sandbin_home | /usr/bin/shasum | /usr/bin/cut -c 1-10`;
    local START_MARK="#sandbin-bootstrap";
    local END_MARK="#end-sandbin-bootstrap";
    local sandbin_config="$sandbin_home/sandbinrc";

    if [ -f $config_file ]; then

        if grep -q "$START_MARK $sandbin_home_sha" "$config_file"; then
            echo "The sandbin bootstrap is already configured in '$config_file'"

        else
            if grep -q "$START_MARK" "$config_file"; then
                echo "Removing old sandbin configuration from '$config_file' file"
                remove_between_marks_in_file "$START_MARK" "$END_MARK\\n" "$config_file"
            fi

            printf "%s\n%s\n%s\n" "$START_MARK $sandbin_home_sha" "source $sandbin_config" "$END_MARK" >> "$config_file"
            echo "The sandbin bootstrap '$sandbin_config' has been configured in '$config_file'"
        fi
    fi
}

### BANNER functions

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
        printf "${RED}%s${NORMAL}\n" "                                                               revision: $version"
    fi
}

function sandbin_version() {
    cd "$SANDBIN_HOME"

    git fetch >/dev/null 2>&1
    echo $(git for-each-ref refs/tags --sort=-taggerdate --format='%(refname:short)' --count=1)
}
