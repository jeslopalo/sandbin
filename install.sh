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
  GREEN="$(tput setaf 2)"
  YELLOW="$(tput setaf 3)"
  BLUE="$(tput setaf 4)"
  NORMAL="$(tput sgr0)"
else
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
	echo "You already have sandbin installed. You'll need to remove $SANDBIN_HOME if you want to reinstall"
    exit
fi

echo "Cloning sandbin..."
hash git >/dev/null 2>&1 && env git clone https://github.com/jeslopalo/sandbin.git $SANDBIN_HOME || {
  echo "git not installed"
  exit
}

if [ "$revision" != "" ]; then
    cd "$SANDBIN_HOME"
    git checkout "$revision"
fi

function configure_sandbin_bootstrap() {
    local config_file=$1;
    local sandbin_home=$2;
    local sandbin_config="$sandbin_home/.sandbinrc"

    if grep -q "{{sandbinhome}}" $sandbin_config; then
        echo "Configuring sandbin home '$sandbin_home' in '$sandbin_config'"
        local curated_sandbin_home=${sandbin_home//\//\\\/}
        perl -pi -e "s/{{sandbinhome}}/\"$curated_sandbin_home\"/g" "$sandbin_config"
    fi

    if [ -f $config_file ]; then

        if grep -q "source $sandbin_config" $config_file; then
            echo "sandbin bootstrap is already configured in '$config_file'"
        else
            echo "\n# sandbin bootstrap\nsource $sandbin_config\n" >> $config_file
            echo "sandbin bootstrap configuration '$sandbin_config' has been configured in '$config_file'"
        fi
    fi
}

configure_sandbin_bootstrap ~/.bashrc "$SANDBIN_HOME"
configure_sandbin_bootstrap ~/.zshrc "$SANDBIN_HOME"

printf '%s' "$GREEN"
printf '%s\n' ''
printf '%s\n' '                                          oooo oooo       o88'
printf '%s\n' ' oooooooo8    ooooooo   oo oooooo    ooooo888   888ooooo  oooo  oo oooooo'
printf '%s\n' '888ooooooo    ooooo888   888   888 888    888   888    888 888   888   888'
printf '%s\n' '        888 888    888   888   888 888    888   888    888 888   888   888 '
printf '%s\n' '88oooooo88   88ooo88 8o o888o o888o  88ooo888o o888ooo88  o888o o888o o888o '
printf '%s\n' ''
printf "${BLUE}%s\n" "Hooray! Sandbin has been installed."
printf "${YELLOW}%s${NORMAL}\n" "Please, reload your shell session!"


