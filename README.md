# lyft-dev-shortcuts

## Intro
Typing commands can be time consuming at Lyft especially with the amount of repos and environments to deal with. The shortcuts provided in this repo all read from your current file directory.

### Getting Started

Run this in your terminal of choice
```shell
sh -c "$(curl -fsSL https://raw.githubusercontent.com/brandonhuang/lyft-dev-shortcuts/master/install.sh)"
```

For changes to take effect, you'll have to restart terminal. If you want to update just the current window, you can run
```shell
source ~/.zshrc
source ~/.bash_profile
```

## Shortcuts
### Devbox
1. `dbc` - enter the devbox container for the current folder's service
2. `dbt` - tail web logs for the current folder's service

### Onebox

#### Workflow
NOTE: Run the following steps - you won't be able to use the aliases without them:

```shell
# Sets up your onebox name to work with the rest of the aliases
upstream YOUR_ONEBOX

# Enter your onebox that you just set up
ob

# Start up the service on your onebox
control ensure -g YOUR_SERVICE_NAME.dev
```

#### Aliases
1. `ob` - enter onebox
2. `obc` - enter the onebox container for current folder's service
3. `obt` - tail web logs for the current folder's service
4. `sync` - run hack sync script on the current folder's service
5. `upstream` - set upstream onebox name

