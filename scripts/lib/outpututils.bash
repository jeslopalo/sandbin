#!/bin/bash

#Script name
outpututils_me=`basename $0`

#Fonts format
outpututils_bold=`tput bold`
outpututils_normal=`tput sgr0`

#Debug
debug=false


# Text formatting ------------------------------------------------
function format.b()
{
	local message="$1"

	echo "$outpututils_bold$message$outpututils_normal"
}


# Trace ----------------------------------------------------------
function out.debug()
{
	local debug="$1"
	local message="$2"

	if [ "$debug" = "true" ]; then
		echo "[debug] $message"		
	fi
}


# Application info ----------------------------------------------
function app.me()
{
	echo $outpututils_me;
}


# Assertions ----------------------------------------------------
function assert.not_null()
{
	local argument="$1"
	local message="$2"

	if [ "$argument" = "" ]; then
		echo -e "$(app.me): ERROR: $message"
		exit 1		
	fi	
}
