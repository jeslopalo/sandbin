[[ -f $ZSH_CUSTOM/plugins/applog/applog.zsh ]] && source $ZSH_CUSTOM/plugins/applog/applog.zsh
[[ -f $ZSH/plugins/applog/applog.zsh ]] && source $ZSH/plugins/applog/applog.zsh

function applog_command() {
	if [[ "$1" = "" ]]; then
		applog
	else
		applog -a $@ 		
	fi	
}

alias viewlog=applog_command