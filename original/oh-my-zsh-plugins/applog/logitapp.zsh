#!/bin/bash

function usage
{
	echo "Usage: $(boldme $me) $(boldme -a) application [[$(boldme -l) lines] [$(boldme -f) filter] [$(boldme -H) term] [$(boldme -d)] [$(boldme -t)] | $(boldme -h)]"
	echo "  $(boldme '-a, --application')	applications: (mobile | intranet | intrapps | cas)"
	echo "  $(boldme '-t, --test')		test log"
	echo "  $(boldme '-l, --lines')		initial number of tail lines"
	echo "  $(boldme '-f, --filter')		filter expression (@see grep -E))"
	echo "  $(boldme '-F, --file')		log file path without extension (.log)"
	echo "  $(boldme '-d, --debug')		debug output"
	echo "  $(boldme '-h, --help')		show this message"
	echo "  $(boldme '-H, --highlight')     highlight a term"
	echo ''
}


function description
{
	echo "Tailing $(boldme $application) application, starting with $(boldme $lines) lines..."
}


function debug
{
	if $debug; then
		echo "$1"
	fi
}

function executeTail
{
	description
##	if [[ "$grepFilter" != "" && "$highlightTerm" != "" ]] ; then
	if [ "X$grepFilter" != 'X' ]; then
		if [ "X$highlightTerm" != 'X' ]; then
			echo distintos;
			debug "Executing -> tail --lines $lines -F $logFile | grep --color=always -E $grepFilter | perl -pe s/$highlightTerm/\e[1;31;43m$&\e[0m/g"
			echo "------------------------------------------------------------------------------------------------"
			tail --lines $lines -F "$logFile" | grep --binary-files=text --color=always -i -E "$grepFilter" | perl -pe "s/$highlightTerm/\e[1;33;44m$&\e[0m/g"
		else
			debug "Executing -> tail --lines $lines -F $logFile | grep --color=always -E $grepFilter"
			echo "------------------------------------------------------------------------------------------------"
			tail --lines $lines -F "$logFile" | grep --binary-files=text --color=always -i -E "$grepFilter"
		fi
	elif ["$highlightTerm" != "" ]; then
		debug "Executing -> tail --lines $lines -F $logFile | perl -pe s/$highlightTerm/\e[1;31;43m$&\e[0m/g"
		echo "------------------------------------------------------------------------------------------------"
		tail --lines $lines -F "$logFile" | perl -pe "s/$highlightTerm/\e[1;31;43m$&\e[0m/g"

	else
		debug "Executing -> tail --lines $lines -F $logFile"
		echo "------------------------------------------------------------------------------------------------"
		tail --lines $lines -F "$logFile"
	fi
}

function boldme
{
	echo "$bold$1$normal"
}

#Nombre del script
me=`basename $0`
#Formateo de fuentes
bold=`tput bold`
normal=`tput sgr0`

#Logs conocidos
PATH_SPRINGBOX=/log/sandbox.es/springbox/springbox
PATH_MOBILE=/log/mercantil/corpme-mobile/corpme-mobile
PATH_INTRANET=/log/intranet/intranet/intranet
#PATH_AUTHORIZATIONS=/log/intranet/intrapps/intrapps.log
PATH_INTRAPPS=/log/intranet/intrapps/intrapps
PATH_INTRAPPS_ADM=/log/intranet/intrapps/intrapps-adm
PATH_INTRAPPS_ACCESS_AUDITOR=/log/intranet/intrapps/audit
PATH_CORPME_ACCESS_AUDITOR=/log/corpme/common/access-auditor
PATH_CAS=/log/intranet/cas/cas

PATH_OPOSICIONES=/log/principal/oposiciones/oposiciones
PATH_CONCURSAL=/log/es.corpme.app.concursal/concursal-web

TEST_SUFFIX="-test"
DEFAULT_EXTENSION=".log"

#DEFAULT_FILTER="(\||>|\[|TRACE|DEBUG|INFO|WARN|ERROR|FATAL|\]|\{|\})"
#DEFAULT_FILTER="(\||\[|TRACE|DEBUG|INFO|WARN|ERROR|FATAL|\]|\{|\}|exception)"
DEFAULT_FILTER="(\||>|<|\[|\]|\{|\}|\\(|\\)|exception|WARN|ERROR|FATAL|\\n)"

DEFAULT_HIGHLIGHT_TERM="";

#Valores por defecto
lines=50;
grepFilter=$DEFAULT_FILTER;
highlightTerm=$DEFAULT_HIGHLIGHT_TERM;
application="unknown";
test=false;
debug=false;
logFile=

#Control de parametros
while [ "$1" != "" ]; do
    case $1 in
	-a | --application )
			shift
			application="$1"
            ;;
	-t | --test )
			echo "Test file selected";
			test=true
	    ;;
        -l | --lines )
			shift
			lines="$1"
            ;;
	-f | --filter)
			shift
			grepFilter="$1"
		;;
	-F | --file)
			shift
			echo "Logging this file: $(boldme $1)"
			application="unknown"
			logFile="$1"
		;;
	-H | --highlight)
			shift
			echo "Highlighting words: $(boldme $1)"
			highlightTerm="$1"
		;;
	-d | --debug)
			echo "Debug mode $(boldme on)";
			debug=true
		;;
        -h | --help )
			usage
			exit
            ;;
        * )
			usage
			exit 1
	;;
    esac

    shift
done

#Si el numero de lineas no es un numero --> go away!!
if ! [ $lines -eq $lines 2> /dev/null ]; then
	echo "$(boldme $lines) is not numeric"
	usage
	exit 1
fi

function generate_filename
{
	local filename=$1
	local suffix=$2

	if $suffix; then
		filename=$filename$TEST_SUFFIX
	fi

	filename=$filename$DEFAULT_EXTENSION
	echo "$filename"
}

#Control de la aplicacion a trazar
case $application in
	springbox | sandbox | sandbox.es )
		logFile=$(generate_filename "$PATH_SPRINGBOX" $test)
		;;
	mobile )
		logFile=$(generate_filename "$PATH_MOBILE" $test)
		;;
	intranet )
		logFile=$(generate_filename "$PATH_INTRANET" $test)
		;;
	audit )
		logFile=$(generate_filename "$PATH_CORPME_ACCESS_AUDITOR" $test)
		;;
	intrapps-audit )
		logFile=$(generate_filename "$PATH_INTRAPPS_ACCESS_AUDITOR" $test)
		;;		
	intrapps )
		logFile=$(generate_filename "$PATH_INTRAPPS" $test)
		;;
	intrapps-adm )
		logFile=$(generate_filename "$PATH_INTRAPPS_ADM" $test)
		;;
	cas)
		logFile=$(generate_filename "$PATH_CAS" $test)
		;;
	oposiciones)
		logFile=$(generate_filename "$PATH_OPOSICIONES" $test)
		;;
	concursal)
		logFile=$(generate_filename "$PATH_CONCURSAL" $test)
		;;
	unknown)
		logFile=$(generate_filename "$logFile" $test)
		echo "$logFile !!"
		;;
	* )
		echo "\"$(boldme $application)\" is an unknown application name"
		usage
		exit 1
		;;
esac


#Ejecucion
executeTail
