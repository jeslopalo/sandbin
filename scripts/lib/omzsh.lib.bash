#!/bin/bash

if [ ! -n "$OM_ZSH_HOME" ]; then
	OM_ZSH_HOME=~/.oh-my-zsh
fi


function installing_omzsh_plugins() {
	echo "\nInstalling zsh plugins in $OM_ZSH_HOME/custom/plugins..."

	mkdir -p "$OM_ZSH_HOME"/custom
	mkdir -p "$OM_ZSH_HOME"/custom/plugins

	for plugin in $(ls "$SANDBIN_HOME/scripts/oh-my-zsh/plugins"); do
		echo "- $SANDBIN_HOME/scripts/oh-my-zsh/plugins/$plugin to $OM_ZSH_HOME/custom/plugins/$plugin"
		ln -s "$SANDBIN_HOME/scripts/oh-my-zsh/plugins/$plugin" "$OM_ZSH_HOME/custom/plugins/$plugin"
	done
}

