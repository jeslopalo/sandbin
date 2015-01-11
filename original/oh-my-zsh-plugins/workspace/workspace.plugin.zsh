[[ -f $ZSH_CUSTOM/plugins/workspace/workspace.zsh ]] && source $ZSH_CUSTOM/plugins/workspace/workspace.zsh
[[ -f $ZSH/plugins/workspace/workspace.zsh ]] && source $ZSH/plugins/workspace/workspace.zsh

#source $ZSH/plugins/workspace/workspace.sh

function go_to_workspace() {
	if [[ "$1" = "" ]]; then
		workspace -g -w .
	else
		workspace -g -w $@ 		
	fi
}

alias gtw=go_to_workspace