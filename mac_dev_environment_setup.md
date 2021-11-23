## List of Apps and Settings

### Setting changes

- keyboard -> key repeat -> fastest setting
- keyboard -> Delay Until Repeat -> fastest setting
- keyboard -> shortcuts -> spotlight -> untick both options
- keyboard -> touchbar shows -> expanded control strip
- keyboard -> press fn key to -> show f1, f2 etc keys
- keyboard -> text (tab) -> uncheck top 4 boxes (correct spelling etc...)
- dock -> smaller size
- (when connected to second monitor) displays -> (uncheck) high dynamic range
- mouse -> scrolling speed -> third fastest
- mouse -> tracking speed -> third slowest (uses gaming mouse speed)

### Chrome
https://www.google.co.uk/chrome

### Brave
https://try.bravesoftware.com/

### Contexts for mac: 
https://contexts.co/

Rules -> Select "Group windows manually"

Rules -> Move the slider for "Number of groups" to 3

Number Switcher -> Tick "Left Command <number>"
  
Number Switcher -> Tick "Show Numbers on Sidebar"

### Visual Studio Code
https://code.visualstudio.com
  
  
Use "Settings Sync: Turn On" in VS Code or do the below:
  
- setup user preferences
- install extensions
- setup custom keybinding for re-do. `cmd + shift + P` -> Search for 'Open Keyboard Shortcuts' -> Search for 'redo' -> edit it to `cmd + Y`
- setup custom keybinding for quick fix. `cmd + '` -> Search for 'Open Keyboard Shortcuts' -> Search for 'quick fix' -> edit both to be `cmd + '`
- disable Inlay Hints

### [Pathfinder mac](https://cocoatech.com/#/)

### [Slack](https://slack.com/downloads/osx)

### [Alfred](https://www.alfredapp.com/)
- Settings -> Keyboard -> Shortcuts -> Spotlight -> untick both options. 
- Assign Alfred to cmd + space.

### [Spotify](https://www.spotify.com/uk/download/mac/)

### [iTerm2](https://www.iterm2.com/) 
- Preferences -> Profiles -> Reuse previous sessions directory

### [Homebrew](https://brew.sh/)

### Homebrew cask

```
brew tap homebrew/cask-versions
brew update
brew tap homebrew/cask
```

### [Oh My Zsh](http://ohmyz.sh/)

If a warning appears on zsh mount (Insecure completion-dependent directories detected), refer to this https://stackoverflow.com/questions/50499750/when-i-update-oh-my-zsh-i-got-a-error-how-do-i-fix-it 

### Add zsh-autosuggestions plugin 

https://github.com/zsh-users/zsh-autosuggestions/blob/master/INSTALL.md#oh-my-zsh

### NVM - Node Version Manager 

`brew install nvm`

You should create NVM's working directory if it doesn't exist:

```
mkdir ~/.nvm
```
Add the following to ~/.zshrc or your desired shell
configuration file then restart it:

```
export NVM_DIR=~/.nvm
source $(brew --prefix nvm)/nvm.sh
or
export NVM_DIR="$HOME/.nvm"
. "/usr/local/opt/nvm/nvm.sh"
```
If you get a permissions error when installing nvm, fix permissions using:

`sudo chown -R $(whoami) /usr/local/var/homebrew`

or last option would be:
`git clone http://github.com/creationix/nvm.git .nvm`

### Setup node and npm using nvm
(first restart iTerm2 after installing nvm)
`nvm install 8.9.4` install specific version or `nvm install --lts`
`nvm use 8.9.4` or `nvm use --lts`

### Create SSH key
https://www.digitalocean.com/docs/droplets/how-to/add-ssh-keys/create-with-openssh/

### Creating SSH keys for different git profiles (home, work etc)
https://gist.github.com/Jonalogy/54091c98946cfe4f8cdab2bea79430f9

then `nano ~/.gitconfig`

and add

```
[url "git@gitlab-enhance:"]
 insteadOf = https://gitlab.dev.enhance.com
```

`gitlab-enhance` is the name of the ssh host which points to a specific ssh key 

Reference https://medium.com/easyread/today-i-learned-fix-go-get-private-repository-return-error-terminal-prompts-disabled-8c5549d89045

### [Postman](https://www.getpostman.com/apps)

  
Postgres
https://www.beekeeperstudio.io/
https://eggerapps.at/postico/
  
### Azure Data Studio - for Postgres GUI 
- Download from https://docs.microsoft.com/en-us/sql/azure-data-studio/download-azure-data-studio?view=sql-server-ver15#download-azure-data-studio
-  Install the PostgreSQL extension 
  
Name: PostgreSQL
Id: microsoft.azuredatastudio-postgresql
Description: PostgreSQL extension for Azure Data Studio
Version: 0.2.7
Publisher: Microsoft
  

### Fork https://git-fork.com/

### [Docker](https://docs.docker.com/v17.09/docker-for-mac/install/)
Set available RAM to 4GB

### Greenshot (appstore) (shortcut: ctrl + .)

### [Dropbox](https://www.dropbox.com/en_GB/downloading)

### [Google Drive](https://www.google.co.uk/drive/download/)

### httpie 

`brew install httpie` - wrapper around cURL

https://httpie.org/



### switch from apple git to updated git

```
git --version
which git
sudo mv /usr/bin/git /usr/bin/git-apple
brew install git
which git
```
Should now be /usr/local/bin/git

### signing into github using two factor auth via the cmd line

Update: May 2020, just use ssh key

Re-generate a personal access token called "macbook-home" here: https://github.com/settings/tokens

Cache username and password in the command line `git config --global credential.helper osxkeychain`

When entering username and password (e.g. while pushing), use the personal access token.

### Balsamiq

### Install Java JDK
https://mkyong.com/java/how-to-install-java-on-mac-osx/

```
brew update
brew tap adoptopenjdk/openjdk
brew search jdk
brew install --cask adoptopenjdk15 #or higher version
/usr/libexec/java_home -V
java -version
```
 
## Troubleshooting

### FIX: battery draining too quickly (reset SMC)
https://www.reddit.com/r/macbookpro/comments/efmy8w/fix_macbook_pro_16_terrible_battery_life/




