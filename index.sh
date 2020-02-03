# Full path of the current script
THIS=`readlink -f "${BASH_SOURCE[0]}" 2>/dev/null||echo $0`
# The directory where current script resides
DIR=`dirname "${THIS}"`

echo $DIR
source "$DIR/devbox_tail_container.sh"
source "$DIR/devbox_enter_container.sh"
source "$DIR/onebox_tail_container.sh"
source "$DIR/onebox_enter_container.sh"
source "$DIR/onebox_enter.sh"
source "$DIR/onebox_set_target.sh"
source "$DIR/sync.sh"
