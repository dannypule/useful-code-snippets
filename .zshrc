# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/dannypule/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"


export NVM_DIR=$HOME/.nvm
source $(brew --prefix nvm)/nvm.sh



# START - aliases and helpers
#
#
echo "~/.zshrc loaded 🥃"

# General aliases and functions
alias c="clear"
alias kp="kill-port" # depends on the kill-port npm package. e.g. `kp 3000` to kill port 3000

# reload zshrc
function _rc() {
  source ~/.zshrc
}

# yarn reinstall from very scratch
function _yarn() {
  echo "doing..."
  _deleteFile yarn.lock
  rm -rf node_modules
  yarn cache clean
  yarn
}

function _deleteFile () {
  FILE=$1
  rm -f $FILE
  echo "Removed ${FILE} 💪"
}

# npm aliases
function rmno() {
  rm -rf node_modules/
}
alias ni="npm i"
alias nr="npm run"
alias ns="npm start"
alias nrs="npm run start"
alias nrsd="npm run start:dev"
alias nrd="npm run dev"
alias nrb="npm run build"
alias nrl="npm run lint"
alias nrlj="npm run lint:js"
alias nrljf="npm run lint:js:fix"
alias nrt="npm run test"
alias nrtw="npm run test:watch"
alias nrtu="npm run test:update"
alias nrtc="npm run test:coverage"
alias nrsb="npm run storybook"
alias nrte="npm run test:e2e"

# git helpers
# commit helper
function _gc() {
  git add . && git commit -m $1 && git push
  echo "short form commit 🤙"
}
alias gpf="gp -f"
alias grd="git rebase develop"
alias grc="git rebase --continue"
alias grh="git reset --hard"

#
#
# END - aliases
# # # # # # # # # # # # # # # # # # # # #

# # # # # # # # # # # # # # # # # # # # #
# START - Enahnce UI repo development scripts
#
#

LOCAL_ROOT_PATH=/Users/dannypule/git/_enhance






function _create_instance () {
  #1. Setup the variables
  ORCHD_TAG=$1
  CONTROLD_TAG=$2
  NAME_BASE=${3-"$ENHANCE_INSTANCE_NAME_BASE"} # Use the 3rd argument otherwise fallback to the global variable
  INSTANCE_NAME="${NAME_BASE}-$RANDOM"

  echo Orchd version: $ORCHD_TAG
  echo Controld version: $CONTROLD_TAG
  echo Instance name: $INSTANCE_NAME

  #2. Remove transaction.yaml which is auto-created sometimes
  cd $LOCAL_ROOT_PATH
  rm -f transaction.yaml # force remove transaction.yaml

  #3. Access deployment repo folder and git pull
  cd $LOCAL_ROOT_PATH/deployment
  git reset --hard origin/master
  git fetch
  git checkout master
  git pull
  cd ..

  #4. Trigger the deployment script
  deployment/install_enhance.sh \
    -i $INSTANCE_NAME \
    -t $GITLAB_ACCESS_TOKEN \
    --reg-key $ENHANCE_REGISTRATION_KEY \
    --registry $DOCKER_REGISTRY \
    --registry-user $DOCKER_REGISTRY_USER \
    --registry-password $DOCKER_REGISTRY_PASSWORD \
    --orchd-tag $ORCHD_TAG \
    --controld-tag $CONTROLD_TAG
}



#
#
# END - UI repo development scripts
# # # # # # # # # # # # # # # # # # # # #


