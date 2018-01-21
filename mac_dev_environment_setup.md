
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
