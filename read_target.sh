user=`cat $(dirname "$0")/onebox_target.txt`
if [ -z "$user" ]; then
    user="bhuang"
fi