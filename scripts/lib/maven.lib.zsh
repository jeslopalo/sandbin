function exists_pom() {
    [ -f "pom.xml" ]
}

function set_version_in_pom() {
    local version="$1"

    mvn -B -q -e versions:set -DnewVersion="$version"
    if [ $? -eq 0 ]; then
        mvn -B -q -e versions:commit
        return $?

    else
        printf "${RED}Sorry but there was an error setting '%s' as version in pom.xml. Reverting changes...${NORMAL}\n" "$version" 1>&2
        mvn -B -q -e versions:revert
        return 1
    fi
}
