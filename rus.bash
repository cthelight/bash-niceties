rus () {
    local RUS_CONTINUE=1
    local RUS_ITER_COUNT=0
    while [[ $RUS_CONTINUE -ne 0 ]]; do
        eval "$@"
        RUS_CONTINUE=$?
        ((++RUS_ITER_COUNT))
    done
    echo "Took $RUS_ITER_COUNT iterations to succeed."
}
