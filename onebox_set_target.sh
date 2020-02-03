function upstream() {
    if [ -z "$1" ]; then
        onebox = `cat $DIR/onebox_target.txt`
        echo onebox
    else
        echo $1 > "$DIR/onebox_target.txt"
        echo "your new onebox target has been set as $1"
    fi
}
