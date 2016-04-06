
# Use colors, but only if connected to a terminal, and that terminal
# supports them.
tput=$(which tput)
if [ -n "$tput" ]; then
    ncolors=$(tput colors)
fi
if [ -t 1 ] && [ -n "$ncolors" ] && [ "$ncolors" -ge 8 ]; then

    #Regular
    BLACK="$(tput setaf 0)"
    RED="$(tput setaf 1)"
    GREEN="$(tput setaf 2)"
    YELLOW="$(tput setaf 3)"
    BLUE="$(tput setaf 4)"
    PURPLE="$(tput setaf 5)"
    CYAN="$(tput setaf 6)"
    WHITE="$(tput setaf 7)"

    #Bright
    BRIGHT_BLACK="$(tput setaf 8)"
    BRIGHT_RED="$(tput setaf 9)"
    BRIGHT_GREEN="$(tput setaf 10)"
    BRIGHT_YELLOW="$(tput setaf 11)"
    BRIGHT_BLUE="$(tput setaf 12)"
    BRIGHT_PURPLE="$(tput setaf 13)"
    BRIGHT_CYAN="$(tput setaf 14)"
    BRIGHT_WHITE="$(tput setaf 15)"

    #Background
    BACKGROUND_BLACK="$(tput setab 0)"
    BACKGROUND_RED="$(tput setab 1)"
    BACKGROUND_GREEN="$(tput setab 2)"
    BACKGROUND_YELLOW="$(tput setab 3)"
    BACKGROUND_BLUE="$(tput setab 4)"
    BACKGROUND_PURPLE="$(tput setab 5)"
    BACKGROUND_CYAN="$(tput setab 6)"
    BACKGROUND_WHITE="$(tput setab 7)"

    #Brightackground
    BRIGHT_BACKGROUND_BLACK="$(tput setab 8)"
    BRIGHT_BACKGROUND_RED="$(tput setab 9)"
    BRIGHT_BACKGROUND_GREEN="$(tput setab 10)"
    BRIGHT_BACKGROUND_YELLOW="$(tput setab 11)"
    BRIGHT_BACKGROUND_BLUE="$(tput setab 12)"
    BRIGHT_BACKGROUND_PURPLE="$(tput setab 13)"
    BRIGHT_BACKGROUND_CYAN="$(tput setab 14)"
    BRIGHT_BACKGROUND_WHITE="$(tput setab 15)"

    NORMAL="$(tput sgr0)"
    BOLD="$(tput bold)"
    UNDERLINE="$(tput smul)"
    REMOVE_UNDERLINE="$(tput rmul)"
    BLINK="$(tput blink)"
    REVERSE="$(tput rev)"
else

    #Regular
    BLACK=""
    RED=""
    GREEN=""
    YELLOW=""
    BLUE=""
    PURPLE=""
    CYAN=""
    WHITE=""

    #Bright
    BRIGHT_BLACK=""
    BRIGHT_RED=""
    BRIGHT_GREEN=""
    BRIGHT_YELLOW=""
    BRIGHT_BLUE=""
    BRIGHT_PURPLE=""
    BRIGHT_CYAN=""
    BRIGHT_WHITE=""

    #Background
    BACKGROUND_BLACK=""
    BACKGROUND_RED=""
    BACKGROUND_GREEN=""
    BACKGROUND_YELLOW=""
    BACKGROUND_BLUE=""
    BACKGROUND_PURPLE=""
    BACKGROUND_CYAN=""
    BACKGROUND_WHITE=""

    #Brightackground
    BRIGHT_BACKGROUND_BLACK=""
    BRIGHT_BACKGROUND_RED=""
    BRIGHT_BACKGROUND_GREEN=""
    BRIGHT_BACKGROUND_YELLOW=""
    BRIGHT_BACKGROUND_BLUE=""
    BRIGHT_BACKGROUND_PURPLE=""
    BRIGHT_BACKGROUND_CYAN=""
    BRIGHT_BACKGROUND_WHITE=""

    NORMAL=""
    BOLD=""
    UNDERLINE=""
    REMOVE_UNDERLINE=""
    BLINK=""
    REVERSE=""
fi