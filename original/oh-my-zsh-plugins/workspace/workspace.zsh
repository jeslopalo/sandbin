# Source the outpututils.bash file ---------------------------------------------------
source /opt/brew/scripts/lib/outpututils.bash
# Source the optparse.bash file ---------------------------------------------------
source /opt/brew/scripts/lib/optparse.bash


function exit_value_to_trap() {
	echo "$OPTPARSE_EXIT_VALUE"
}

# Very dangerous!
exit() {

	if [[ "$1" = "$(exit_value_to_trap)" ]]; then
		return $(exit_value_to_trap);
	fi

	unset -f exit
    exit $1
}


function directoryWorkspace() {

	local name="$1"

	case $name in
		archetype | arch )
			echo "/home/jesuslopez/Desarrollo/Corpme/workspaces/latest-archetype";
			return 0;
			;;
		concursal | rpc )
			echo "/home/jesuslopez/Desarrollo/Flei/009_registro-publico-concursal/workspaces/latest";
			return 0;
			;;
		*)
			return 1;
			;;
	esac
}

function workspace() {
	
	# Define options
	optparse.define short=V long=verbose desc="Flag para activar el modo verbose" variable=verbose_mode value=true default=false
	optparse.define short=g long=go desc="Go action" variable=go value=true default=false
	optparse.define short=m long=make desc="Make action" variable=make value=true default=false

	#optparse.define short=a long=action desc="Accion a realizar con el nombre del espacio de trabajo." variable=action default="go"
	optparse.define short=w long=workspace desc="Nombre del directorio de trabajo." variable=workspace default="."

	# Source the output file ----------------------------------------------------------
	source $( optparse.build )


	if [[ "$workspace" = "." ]]; then
		echo -e "[$(format.b 'WARN')] No action can be performed. A workspace's name is needed!"
		return 1;
	fi
	out.debug $verbose_mode "Working with $(format.b $workspace) as a workspace's name..."

	if [[ "$make" = "true" ]]; then
		echo -e "[$(format.b 'ERROR')] Sorry but $(format.b 'Make') action is not implemented!"
		return 1;
	fi

	if [[ "$go" = "true" ]]; then

		if [[ "$(directoryWorkspace $workspace)" = "" ]]; then
			echo -e "[$(format.b 'ERROR')] $(format.b $workspace) is not a known workspace's name!"
			return 1;
		fi

		if [[ ! -d "$(directoryWorkspace $workspace)" ]]; then		
			echo -e "[$(format.b 'ERROR')] $(format.b $(directoryWorkspace $workspace)) directory not found!"
			return 1;
		fi

		echo -e "The $(format.b $workspace) workspace is configured as located in $(format.b $(directoryWorkspace $workspace))"

		out.debug $verbose_mode "Changing the current path to $(format.b $(directoryWorkspace $workspace))"	
		cd $(directoryWorkspace $workspace)
		return 0;
	fi	
}
