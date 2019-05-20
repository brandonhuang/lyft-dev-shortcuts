function target() {
    if [ -z "$1" ]; then
        echo "please provide target name as first argument."
        exit
    else
        echo $1 > "$(dirname "$0")/onebox_target.txt"
        echo "your new onebox target has been set as $1"
    fi
}
