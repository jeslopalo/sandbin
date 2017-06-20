
extract() {
    local filepath=$1
    local prefix=$2
    local separator=$3
    local lower=$4
    local upper=$5

    local s='[[:space:]]*' w='[a-zA-Z0-9_]*' fs=$(echo @|tr @ '\034') quotes="[\"']"
    sed -ne "s|^\($s\):|\1|" \
        -e "s|^\($s\)\($w\)$s:$s$quotes\(.*\)$quotes$s\$|\1$fs\2$fs\3|p" \
        -e "s|^\($s\)\($w\)$s:$s\(.*\)$s\$|\1$fs\2$fs\3|p" $filepath |
    awk -F$fs '{
        indent = length($1)/2;
        vname[indent] = $2;
        for (i in vname) {if (i > indent) {delete vname[i]}}
        if (length($3) > 0) {
            vn=""; for (i=0; i<indent; i++) {vn=(vn)(vname[i])("'${separator}'")}
            printf("%s%s%s=\"%s\"\n", "'$prefix'", vn, $2, $3);
            if ('${lower:-0}' > 0) {
                printf("%s%s%s=\"%s\"\n", tolower("'$prefix'"), tolower(vn), tolower($2), $3);
            }
            if ('${upper:-0}' > 0) {
                printf("%s%s%s=\"%s\"\n", toupper("'$prefix'"), toupper(vn), toupper($2), $3);
            }
        }
    }' | uniq
}
