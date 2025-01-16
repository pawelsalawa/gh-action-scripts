debug() {
    if [ "${DEBUG}" = "true" ]
    then
        echo "$@" >&2
    fi
}
