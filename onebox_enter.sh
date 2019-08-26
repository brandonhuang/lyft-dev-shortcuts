function ob() {
    if [ -z "$1" ]; then
        source "$DIR/read_target.sh"
    else
        user=$1
    fi

    ssh -t $user-onebox.dev.ln onebox_env
}
