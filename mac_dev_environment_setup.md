
### Installing postgres
https://www.codementor.io/engineerapart/getting-started-with-postgresql-on-mac-osx-are8jcopb#3-configuring-postgres

Install with, `brew install postgresql`

Start postgres with, `brew services start postgresql`

Login into the postgres portal using `psql postgres`

Uninstalling postgres: https://gist.github.com/Atlas7/b1a40a2ffd85728b33e7


### Installing nvm and setting default node version

`brew install nvm`

If nvm command not found on mac, Add this to .zshrc and restart iterm2
source ~/.nvm/nvm.sh

`nvm install 8.9.4` install specific version or `nvm install --lts`

`nvm use 8.9.4` or `nvm use --lts`
