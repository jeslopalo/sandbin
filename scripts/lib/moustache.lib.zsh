
#
# Replaces {{'pattern'}}  with 'value' in 'file'
#
# pattern - $1
# value   - $2
# file    - $3
#
function replace() {
    local pattern=$1;
    local value=$2;
    local file=$3;

    if grep -q "{{$pattern}}" $file; then
        printf "Replacing '%s' with '%s' in '%s' file\n" "$pattern" "$value" "$file"
        local curated_value=${value//\//\\\/}
        perl -pi -e "s/{{$pattern}}/\"$curated_value\"/g" "$file"
    fi
}