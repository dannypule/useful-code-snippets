#### Installing on mac
https://www.codementor.io/engineerapart/getting-started-with-postgresql-on-mac-osx-are8jcopb

#### Starting postgresql and instructing it to start on mac startup after installing via homebrew
`pg_ctl -D /usr/local/var/postgres start && brew services start postgresql`

#### Checking if it's running
`postgres -V`

#### Run the cli
`psql postgres`

#### Show existing users
`\du`
