main() {
  # Use colors, but only if connected to a terminal, and that terminal
  # supports them.
  if which tput >/dev/null 2>&1; then
      ncolors=$(tput colors)
  fi
  if [ -t 1 ] && [ -n "$ncolors" ] && [ "$ncolors" -ge 8 ]; then
    RED="$(tput setaf 1)"
    GREEN="$(tput setaf 2)"
    YELLOW="$(tput setaf 3)"
    BLUE="$(tput setaf 4)"
    BOLD="$(tput bold)"
    NORMAL="$(tput sgr0)"
  else
    RED=""
    GREEN=""
    YELLOW=""
    BLUE=""
    BOLD=""
    NORMAL=""
  fi

  # Only enable exit-on-error after the non-critical colorization stuff,
  # which may fail on systems lacking tput or terminfo
  set -e

  if [ ! -n "$FILE_PATH" ]; then
    FP=~/.lyft_dev_shortcuts
  fi

  if [ -d "$FP" ]; then
    printf "${YELLOW}You already have Lyft Dev Shortcuts installed.${NORMAL}\n"
    printf "You'll need to remove $FP if you want to re-install.\n"
    exit
  fi

  # Prevent the cloned repository from having insecure permissions. Failing to do
  # so causes compinit() calls to fail with "command not found: compdef" errors
  # for users with insecure umasks (e.g., "002", allowing group writability). Note
  # that this will be ignored under Cygwin by default, as Windows ACLs take
  # precedence over umasks except for filesystems mounted with option "noacl".
  umask g-w,o-w

  printf "${BLUE}Cloning Lyft Dev Shortcuts...${NORMAL}\n"
  command -v git >/dev/null 2>&1 || {
    echo "Error: git is not installed"
    exit 1
  }
  # The Windows (MSYS) Git is not compatible with normal use on cygwin
  if [ "$OSTYPE" = cygwin ]; then
    if git --version | grep msysgit > /dev/null; then
      echo "Error: Windows/MSYS Git is not supported on Cygwin"
      echo "Error: Make sure the Cygwin git package is installed and is first on the path"
      exit 1
    fi
  fi
  env git clone --depth=1 https://github.com/brandonhuang/lyft-dev-shortcuts "$FP" || {
    printf "Error: git clone of lyft-dev-shortcuts repo failed\n"
    exit 1
  }

  # add to .zshrc if file exists, otherwise add to bash_profile
  if [[ ! -s "$HOME/.bash_profile" && -s "$HOME/.zshrc" ]] ; then
    profile_file="$HOME/.zshrc"
  else
    profile_file="$HOME/.bash_profile"
  fi

  if ! grep -q '.lyft_dev_shortcuts/index.sh' "${profile_file}" ; then
    printf "Adding source to ${profile_file}\n"
    echo "source '$FP/index.sh'" >> "${profile_file}"
  else
    printf "${YELLOW}Source already exists in ${profile_file}, this is mostly likely due to a previous install, skipping...${NORMAL}\n"
  fi

  printf "${GREEN}"
  echo ' ____               ____            _       _       '
  echo '|  _ \  _____   __ / ___|  ___ _ __(_)_ __ | |_ ___ '
  echo $'| | | |/ _ \ \ / / \___ \ / __| \'__| | \'_ \| __/ __|'
  echo '| |_| |  __/\ V /   ___) | (__| |  | | |_) | |_\__ \'
  echo '|____/ \___| \_/   |____/ \___|_|  |_| .__/ \__|___/'
  echo '                                     |_|             ....is now installed!'
  echo ''
  echo ''
  echo 'Contact @brandonhuang if there are any issues, enjoy!'
  echo ''
  printf "${NORMAL}"
}

main
