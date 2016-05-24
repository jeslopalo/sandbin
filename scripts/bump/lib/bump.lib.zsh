import "scripts/lib/git-functions.lib.zsh"
import "scripts/lib/maven.lib.zsh"



function extract_version_from_branch_name() {

    version=$(git_branch_version)
    if [ ! -z "$version" ] && [ "$version" != "WIP" ]; then
        echo $version
    fi

    return 1
}

#
# Functions: Detecting wheter the workspace contains a versionable file
#

function is_a_shell_project() {
    [ -f "VERSION" ]
}

function is_a_maven_project() {
    exists_pom "$@"
}

function is_versionable() {
    local system=$(version_system "$1")

    case $system in
        maven)
            is_a_maven_project
            return $?
        ;;
        shell)
            is_a_shell_project
            return $?
        ;;
        *)
            return $(is_a_maven_project || is_a_shell_project)
        ;;
    esac
}

#
# Functions: Detecting the version system in the workspace
#

function version_system() {

    case "$1" in
        maven)
            echo "$1"
            return 0
        ;;
        shell)
            echo "$1"
            return 0
        ;;
        *)
            echo "version"
            return 0
        ;;
    esac
}

function version_file() {
    case "$1" in
        maven)
            echo "pom.xml"
            return 0
        ;;
        shell)
            echo "VERSION"
            return 0
        ;;
        *)
            echo "all"
            return 0
        ;;
    esac
}

#
# Bump the version in the versionable file
#

function set_version() {
    local system="$1"
    local version="$2"
    local ret=0

    if [ "$system" = "maven" ] || [ "$system" = "version" ]; then
        if is_a_maven_project; then
            printf "Bumping version in pom.xml to ${BOLD}%s${NORMAL}...\n" "$version"
            ret=$(set_version_in_pom "$version")
        fi
    fi

    if [ "$system" = "shell" ] || [ "$system" = "version" ]; then
        if is_a_shell_project; then
            printf "Bumping version in VERSION to ${BOLD}%s${NORMAL}...\n" "$version"
            ret=$(echo "$version" > VERSION)
        fi
    fi

    return "$ret"
}


#
# Commit files
#
function commit_versionable_files() {
    local system=$(version_system $1)
    local version=$2

    if [ "$system" = "maven" ] || [ "$system" = "version" ]; then
        if is_a_maven_project; then
            git add $(version_file "maven")
            commit=true
        fi
    fi

    if [ "$system" = "shell" ] || [ "$system" = "version" ]; then
        if is_a_shell_project; then
            git add $(version_file "shell")
            commit=true
        fi
    fi

    if [ "$commit" = "true" ]; then
        git commit -m "Bump version to $version"
        return $?
    fi
}
