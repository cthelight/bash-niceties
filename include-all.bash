NICETIES_ALL=$(find "$(dirname $BASH_SOURCE[0])/src/" -type f -name "*.bash")
for SRC_FILE in $NICETIES_ALL
do
    . $SRC_FILE
done