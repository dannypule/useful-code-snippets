### List of Apps

### Chrome

### Chrome Canary

### Contexts for mac: Rules -> Group windows manually... Number Switcher -> Left Command <number>

### Pathfinder mac

### Slack

### Alfred: 
Settings -> Keyboard -> Shortcuts -> Spotlight -> untick both options. Assign Alfred to cmd + space.

### Spotify

### iTerm2: 
Preferences -> Profiles -> Reuse previous sessions directory

### Homebrew

### Oh My Zsh

### NVM - Node Version Manager `brew install nvm`

You should create NVM's working directory if it doesn't exist:

```
mkdir ~/.nvm
```
Add the following to ~/.zshrc or your desired shell
configuration file:

```
export NVM_DIR=~/.nvm
source $(brew --prefix nvm)/nvm.sh
or
export NVM_DIR="$HOME/.nvm"
. "/usr/local/opt/nvm/nvm.sh"
```
If you get a permissions error when installing nvm, fix permissions using:

`sudo chown -R $(whoami) /usr/local/var/homebrew`

### Node/npm via nvm
(first restart iTerm2)
`nvm install 8.9.4` install specific version or `nvm install --lts`
`nvm use 8.9.4` or `nvm use --lts`

### Visual Studio Code
- setup user preferences
- install extensions
- setup custom keybinding for re-do. `cmd + shift + P`, Search for 'Open Keyboard Shortcuts', Search for 'redo', edit it to `cmd + Y`

### Postman

### Postgres (install instructions below)

### PSequel (see installation steps below)

### Docker

### Greenshot (appstore) (shortcut: ctrl + .)

### Dropbox

### Google Drive

### httpie (brew install httpie) - wrapper around cURL


### Installing postgres
https://www.codementor.io/engineerapart/getting-started-with-postgresql-on-mac-osx-are8jcopb#3-configuring-postgres

Install with, `brew install postgresql`

Start postgres with, `brew services start postgresql`

Login into the postgres portal using `psql postgres`

Uninstalling postgres (via homebrew): https://gist.github.com/Atlas7/b1a40a2ffd85728b33e7

### Postgresql client

http://www.psequel.com

After entering connection details for remote db (created via heroku) select 'Connect via SSL' then click 'Connect'


### Installing nvm and setting default node version

`brew install nvm`

If nvm command not found on mac, Add this to .zshrc and restart iterm2
source ~/.nvm/nvm.sh

`nvm install 8.9.4` install specific version or `nvm install --lts`

`nvm use 8.9.4` or `nvm use --lts`

### switch from apple git to updated git

`git --version`
`which git`
`sudo mv /usr/bin/git /usr/bin/git-apple`
`brew install git`
`which git` (should now be /usr/local/bin/git)

### signing into github using two factor auth via the cmd line

Generate a personal access token here: https://github.com/settings/tokens

Cache username and password in the command line `git config --global credential.helper osxkeychain`

When entering username and password (e.g. while pushing), use the personal access token.


### nvm command not found on mac
- Restart iTerm2 after initial installation. Then retry.
- Ensure nvm directory was created `mkdir ~/.nvm`
- Add the following to .zshrc:
```
export NVM_DIR="$HOME/.nvm"
. "/usr/local/opt/nvm/nvm.sh"
or
```

or last option would be:
`git clone http://github.com/creationix/nvm.git .nvm`

Add this to .zshrc and restart iterm2

`source ~/.nvm/nvm.sh`



