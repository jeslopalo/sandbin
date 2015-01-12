#!/bin/zsh

# Source the outpututils.bash file ---------------------------------------------------
source ../../lib/outpututils.bash

canonical_script=$(cd -P -- "$(dirname -- "$0")" && printf '%s\n' "$(pwd -P)/$(basename -- "$0")")
canonical_path=$(cd -P -- "$(dirname -- "$0")" && printf '%s\n' "$(pwd -P)")

TARGET_DIRECTORY="$canonical_path/target"


function applog() {

	parse_options $*

	if [[ "$application" == "" ]]; then
		echo -e "[$(format.b 'WARN')] No action can be performed. A application's name is needed!";
		usage;
		return 1;
	fi

	echo "Tailing log messages for $(format.b $application) aplication (starting with $lines lines)...";
	tail_application $application $lines
}

function tail_application() {
	local application_id=$1;
	local application_logs_path=$(readlink -f "$TARGET_DIRECTORY/$application_id")	
	
	local lines=$2;

	if [[ -d "$application_logs_path" ]]; then
		local application_log_file_path=$(setopt dotglob ; print $application_logs_path/**/$application_id.log(om[1]))
		
		tail --lines $lines -F $application_log_file_path;
	fi
	echo -e "[$(format.b 'WARN')] No action can be performed. The log file is not found!";
}

function parse_options()
{
    o_application=(-a "")
    o_lines=(-l 50)

    zparseopts -K -- a:=o_application l:=o_lines h=o_help
    if [[ $? != 0 || "$o_help" != "" ]]; then
    	usage        
        exit 1;
    fi

    application=$o_application[2];
    lines=$o_lines[2];
}

function usage() {
	echo -e "Usage: applog [-a APPLICATION_NAME] [-h] [-l lines]"
	application_list
	return 0;
}

function application_list() {	
	if [[ -d $TARGET_DIRECTORY ]]; then		
		local list="";
		
		for application in $(dir "$TARGET_DIRECTORY"); do
			if [[ "$list" == "" ]]; then
				list=$application;
			else
				list="$list, $application";
			fi
		done		 
		echo "Applications: $list";
	fi
}
