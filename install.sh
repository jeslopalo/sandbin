#@IgnoreInspection AddShebangLine

while [[ $# > 0 ]];  do
    key="$1"

    case $key in
        --sandbin-home)
        SANDBIN_HOME="$2"
        shift
        ;;
        -F|--force-reinstall)
        force_reinstall=1
        ;;
        --from-dir)
        install_from_dir="$2"
        shift
        ;;
        --revision)
        revision="$2"
        shift
        ;;
    esac
    shift
done

set -e

# Use colors, but only if connected to a terminal, and that terminal
# supports them.
tput=$(which tput)
if [ -n "$tput" ]; then
    ncolors=$(tput colors)
fi
if [ -t 1 ] && [ -n "$ncolors" ] && [ "$ncolors" -ge 8 ]; then
    RED="$(tput setaf 1)"
    GREEN="$(tput setaf 2)"
    YELLOW="$(tput setaf 3)"
    BLUE="$(tput setaf 4)"
    NORMAL="$(tput sgr0)"
else
    RED=""
    GREEN=""
    YELLOW=""
    BLUE=""
    NORMAL=""
fi

if [ ! -n "$SANDBIN_HOME" ]; then
	SANDBIN_HOME=~/.sandbin
fi

if [ $force_reinstall ]; then
    printf "Uninstalling sandbin from '%s' directory...\n" "$SANDBIN_HOME"
    rm -rf $SANDBIN_HOME
fi
printf "Installing sandbin in '%s' directory...\n" "$SANDBIN_HOME"

if [ -d "$SANDBIN_HOME" ]; then
	echo "You already have sandbin installed. You'll need to remove $SANDBIN_HOME if you want to reinstall" 1>&2
    exit 1
fi

if [ -z $install_from_dir ]; then

    echo "Cloning sandbin..."
    hash git >/dev/null 2>&1 && env git clone https://github.com/jeslopalo/sandbin.git $SANDBIN_HOME || {
      echo "git not installed" 1>&2
      exit 1
    }

    if [ -z "$revision" ]; then
        revision="master"
    else
        cd "$SANDBIN_HOME"
        git checkout "$revision"
    fi
else
    echo "Installing from local directory $install_from_dir to $SANDBIN_HOME"
    cp -R "$install_from_dir" $SANDBIN_HOME
fi

# replace function is in moustache.lib
function replace() {
    local pattern=$1;
    local value=$2;
    local file=$3;

    if grep -q "{{$pattern}}" $file; then
        printf "Replacing '%s' with '%s' in '%s' file\n" "$pattern" "$value" "$file"
        local curated_value=${value//\//\\\/}
        perl -pi -e "s/{{$pattern}}/\"$curated_value\"/g" "$file"
    fi
}

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

generate_sandbin_config_file "$SANDBIN_HOME"
configure_sandbin_bootstrap ~/.bashrc "$SANDBIN_HOME"
configure_sandbin_bootstrap ~/.zshrc "$SANDBIN_HOME"

source "${SANDBIN_HOME}/scripts/sandbin/lib/sandbin.lib.zsh"

print_sandbin_banner "$(sandbin_version)" "${GREEN}${BOLD}" "sandbin"
printf "%s\n" "${BLUE}Hooray! Sandbin has been installed.${NORMAL}"
printf "%s\n" "${YELLOW}Please, reload your shell session!${NORMAL}"


