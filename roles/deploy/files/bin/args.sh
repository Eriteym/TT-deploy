SCRIPTSRC=`readlink -f "$0" || echo "$0"`
SCRIPT_PATH=`dirname "$SCRIPTSRC" || echo .`
echo "Script path: ${SCRIPT_PATH}"

# process params
while [ "$1" != "" ]; do
    PARAM=`echo $1 | awk -F= '{print $1}'`
    case $PARAM in
        -d | --debug)
            echo "+ debug"
            DEBUG=1
            ;;
        -f | --force)
            echo "+ force"
            FORCE=1
            ;;
        -l | --logs)
            echo "+ show logs"
            LOGS=1
            ;;
        *)
            echo "ERROR: unknown parameter \"$PARAM\""
            exit 1
            ;;
    esac
    shift
done
