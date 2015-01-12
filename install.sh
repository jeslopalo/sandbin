set -e

if [ ! -n "$SANDBIN_HOME" ]; then
	SANDBIN_HOME=~/.sandbin
fi

if [ ! -n "$OM_ZSH_HOME" ]; then
	OM_ZSH_HOME=~/.oh-my-zsh
fi

if [ -d "$SANDBIN_HOME" ]; then
	echo "\033[0;33mYou already have sandbin installed.\033[0m You'll need to remove $SANDBIN_HOME if you want to install"
    	exit
fi

echo "\033[0;34mCloning sandbin...\033[0m"
hash git >/dev/null 2>&1 && env git clone https://github.com/jeslopalo/sandbin.git $SANDBIN_HOME || {
  echo "git not installed"
  exit
}

if [ -d "$OM_ZSH_HOME" ]; then
	echo "\033[0;33mInstalling zsh plugins...\033[0m"
	mkdir -p "$OM_ZSH_HOME"/custom
	# mkdir -p "$OM_ZSH_HOME"/custom/plugins
	ln -s "$SANDBIN_HOME"/scripts/oh-my-zsh/plugins plugins

fi
