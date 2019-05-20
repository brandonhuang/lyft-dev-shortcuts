user=`cat ${BASH_SOURCE%/*}/onebox_target.txt`
if [ -z "$user" ]; then
    user="bhuang"
fi