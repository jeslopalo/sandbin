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

else
    echo "Installing from local directory $install_from_dir to $SANDBIN_HOME"
    cp -R "$install_from_dir" $SANDBIN_HOME
fi

source "${SANDBIN_HOME}/scripts/sandbin/lib/sandbin.lib.zsh"

if [ -z "$revision" ]; then
    revision="$(sandbin_latest_version)"
else
    cd "$SANDBIN_HOME"
    git checkout "$revision"
fi

generate_sandbin_config_file "$SANDBIN_HOME"
configure_sandbin_bootstrap ~/.bashrc "$SANDBIN_HOME"
configure_sandbin_bootstrap ~/.zshrc "$SANDBIN_HOME"

print_sandbin_banner "$revision" "${GREEN}${BOLD}" "sandbin"
printf "%s\n" "${BLUE}Hooray! Sandbin has been installed.${NORMAL}"
printf "%s\n" "${YELLOW}Please, reload your shell session!${NORMAL}"


