#!/bin/zsh

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