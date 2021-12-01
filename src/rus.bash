. "$(dirname $BASH_SOURCE[0])/niceties_helper_funcs.bash_helper"

rus () {
    local RUS_DELAY=0
    local RUS_VERBOSE=false
    local RUS_MAX_ITER=-1
    local RUS_ERROR_COLOR="Red"
    local RUS_INFO_COLOR="Yellow"
    local RUS_SUCCESS_COLOR="Light Blue"

    # Basic arg parsing
    while [[ ${1:0:1} == "-" ]]; do
        case ${1:1} in

        "d")
            [[ "$#" -lt "2" ]] && { niceties_helper_color_echo "Need to specify delay after -d. Exiting...\n" "$RUS_ERROR_COLOR"; return; }
            # Check if integer
            [[ $2 == ?(-)+([0-9]) ]] || { niceties_helper_color_echo "Value passed to -d is not an integer. Exiting...\n" "$RUS_ERROR_COLOR"; return; } 
            RUS_DELAY=$2
            # Considered arg (and the next), move on 2x
            shift
            shift
            ;;
        "v")
            RUS_VERBOSE="true"
            # Considered arg, move on
            shift
            ;;
        "m")
            [[ "$#" -lt "2" ]] && { niceties_helper_color_echo "Need to specify max iterations after -m. Exiting...\n" "$RUS_ERROR_COLOR"; return; }
            # Check if integer
            [[ $2 == ?(-)+([0-9]) ]] || { niceties_helper_color_echo "Value passed to -m is not an integer. Exiting...\n" "$RUS_ERROR_COLOR"; return; } 
            RUS_MAX_ITER=$2
            # Considered arg (and the next), move on 2x
            shift
            shift
            ;;
        *)
            # Do Nothing in default case
            ;;

        esac
    done
    # Verify there is a command remaining to run
    [[ "$#" == "0" ]] && { niceties_helper_color_echo "No command specified. Exiting...\n" "$RUS_ERROR_COLOR"; return; }
    local RUS_CONTINUE=1
    local RUS_ITER_COUNT=0
    while [[ $RUS_CONTINUE -ne 0 ]] && { [[ $RUS_ITER_COUNT -lt $RUS_MAX_ITER ]] || [[ $RUS_MAX_ITER -lt 0 ]]; }; do
        # Skip the delay on the first attempt
        [[ $RUS_ITER_COUNT -gt 0 ]] && sleep $RUS_DELAY
        [[ "$RUS_VERBOSE" == "true" ]] && niceties_helper_color_echo "---Starting iteration $RUS_ITER_COUNT.---\n" "$RUS_INFO_COLOR"
        eval "$@"
        RUS_CONTINUE=$?
        ((++RUS_ITER_COUNT))
    done
    if [[ $RUS_CONTINUE -ne 0 ]]; then
        niceties_helper_color_echo "\n---Reached maximum iterations without success. Exiting...---\n" "$RUS_ERROR_COLOR"
        # Cause a subshell to fail to give proper error code
        (exit 1)
    else
        niceties_helper_color_echo "\n---Took $RUS_ITER_COUNT iterations to succeed.---\n" "$RUS_SUCCESS_COLOR"
    fi
}
