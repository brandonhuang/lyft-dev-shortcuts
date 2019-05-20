function lnua() {
  local gitroot="$(git rev-parse --show-toplevel)"
  local dest="/srv/service_npm_modules"

  # Ensure that gemfury npm registry has been configured
  [[ -z $(npm -g config list | grep "@lyft:registry") ]] && (
    npm -g config set @lyft:registry https://npm-proxy.fury.io/drM6auMDVB6xY2SH5HWq/lyft/
  )

  # Remove current files and folders in destination. Guard execution
  # errors for first time users of the script.
  ls -l $dest/package*json > /dev/null 2>&1
  if [ "$?" = "0" ]; then
    echo "removing" $dest/package*json
    rm -f $dest/package*json
  fi

  ls -l $dest/*.log > /dev/null 2>&1
  if [ "$?" = "0" ]; then
    echo "removing" $dest/*.log
    rm -f $dest/*.log
  fi

  if [ -d $dest/node_modules ]; then
    echo "removing" $dest/node_modules
    rm -rf $dest/node_modules
  fi

  if [ -d $dest/.git ]; then
    echo "removing" $dest/.git
    rm -rf $dest/.git
  fi

  # Create a git hooks folder in destination for Husky to write to.
  echo "creating" $dest/.git/hooks
  mkdir -p $dest/.git/hooks

  # Copy gitroot package*.json files to destination and run npm ci/install.
  [[ -f $gitroot/package.json ]] && (
    [[ -f $gitroot/.nvmrc ]] && (
      echo "copying .nvmrc"
      cp $gitroot/.nvmrc "$dest"
    )
    [[ -f $gitroot/package.json ]] && (
      echo "copying package.json"
      cp $gitroot/package.json "$dest"
    )
    [[ -f $gitroot/package-lock.json ]] && (
      echo "copying package-lock.json"
      cp $gitroot/package-lock.json "$dest"
    )
    echo "cd to destination"
    cd "$dest"
    echo "change node version"
    nvm use > /dev/null 2>&1
    echo "node version: $(node -v)"
    echo "npm version: $(npm -v)"
    echo "installing dependencies"
    [[ -f $dest/package-lock.json ]] && (
      echo "running npm ci"
      npm ci
    ) || (
      echo "running npm install"
      npm install
    )
    echo "updated $dest"
  )

  # Husky git hooks should now be installed, so copy over the installed
  # git hooks from the destination back to the gitroot git hooks folder.
  ls -l $dest/.git/hooks/* > /dev/null 2>&1
  if [ "$?" = "0" ]; then
    echo "copying git hooks"
    mkdir -p $gitroot/.git/hooks
    cp -f $dest/.git/hooks/* $gitroot/.git/hooks
  fi
}
