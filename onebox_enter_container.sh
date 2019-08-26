function obc() {
    if [ -z "$1" ]; then
        service=${PWD##*/}
    else
        service=$1
    fi

    if [ -z "$2" ]; then
        source "$DIR/read_target.sh"
    else
        user=$2
    fi

    # lyft.com repo is www2 service
    if [[ "$service" == "lyft.com" ]]; then
        service="www2"
    fi

    echo "ssh to container $service"
    ssh -t $user-onebox.dev.ln onebox_env control enter $service.legacy
}

