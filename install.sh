#@IgnoreInspection AddShebangLine

set -e

if [ ! -n "$SANDBIN_HOME" ]; then
	SANDBIN_HOME=~/.sandbin
fi

if [ ! -n "$OM_ZSH_HOME" ]; then
	OM_ZSH_HOME=~/.oh-my-zsh
fi

if [ -d "$SANDBIN_HOME" ]; then
	echo "You already have sandbin installed. You'll need to remove $SANDBIN_HOME if you want to reinstall"
    exit
fi

echo "Cloning sandbin..."
hash git >/dev/null 2>&1 && env git clone https://github.com/jeslopalo/sandbin.git $SANDBIN_HOME || {
  echo "git not installed"
  exit
}


if [ -d "$OM_ZSH_HOME" ]; then
	echo "\nInstalling zsh plugins in $OM_ZSH_HOME/custom/plugins..."
	
	mkdir -p "$OM_ZSH_HOME"/custom
	mkdir -p "$OM_ZSH_HOME"/custom/plugins

	for plugin in $(ls "$SANDBIN_HOME/scripts/oh-my-zsh/plugins"); do
		echo "- $SANDBIN_HOME/scripts/oh-my-zsh/plugins/$plugin to $OM_ZSH_HOME/custom/plugins/$plugin"
		ln -s "$SANDBIN_HOME/scripts/oh-my-zsh/plugins/$plugin" "$OM_ZSH_HOME/custom/plugins/$plugin"
	done
fi

function reload_shell_config() {
	echo "\nReloading shell configuration..."

	if test -n "$ZSH_VERSION"; then
		. ~/.zshrc
		echo "- Sourced ~/.zshrc file again..."
	elif test -n "$BASH_VERSION"; then
		. ~/.bashrc
		echo "- Sourced ~/.bashrc file again..."
	fi
}

function update_path() {
	local config=$1;

	if [ -f $config ]; then

		if [[ ! ":$PATH:" == *":$SANDBIN_HOME/scripts:"* ]]; then
			echo "\nUpdating $config PATH declaration..."

			if grep -q "export PATH=$SANDBIN_HOME/scripts:\$PATH" $config; then
				echo "sandbin is already declared in $config!"		
			else
				echo "\nexport PATH=$SANDBIN_HOME/scripts:\$PATH" >> $config
				echo "sandbin directory has been declared in path!"
			fi
		fi
	fi
}

zsh_config=~/.zshrc
bash_config=~/.bashrc

update_path "$bash_config"
update_path "$zsh_config"

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
  BOLD="$(tput bold)"
  NORMAL="$(tput sgr0)"
else
  RED=""
  GREEN=""
  YELLOW=""
  BLUE=""
  BOLD=""
  NORMAL=""
fi

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

#reload_shell_config


