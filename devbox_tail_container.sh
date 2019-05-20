function ob() {
    if [ -z "$1" ]; then
        service=${PWD##*/}
    else
        service=$1
    fi

    if [ -z "$2" ]; then
        source "${BASH_SOURCE%/*}/read_target.sh"
    else
        user=$2
    fi

    # lyft.com repo is www2 service
    if [ "$service" == "lyft.com" ]; then
        service="www2"
    fi

    echo "ssh to container $service"
    control enter $service.legacy tail -F /var/log/$service-web/current | perl -p -e 's/\\n/\r/g'
}
