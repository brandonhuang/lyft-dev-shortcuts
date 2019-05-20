function dbc() {
    if [ -z "$1" ]; then
        service=${PWD##*/}
    else
        service=$1
    fi

    # lyft.com repo is www2 service
    if [[ "$service" == "lyft.com" ]]; then
        service="www2"
    fi

    echo "entering devbox container $service"
    control enter $service.legacy
}