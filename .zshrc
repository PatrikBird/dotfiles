setopt HIST_IGNORE_SPACE
setopt INC_APPEND_HISTORY  # write to history immediately, not on exit
setopt HIST_IGNORE_DUPS  # don't save duplicate adjacent commands
setopt HIST_REDUCE_BLANKS
YHISTSIZE=100000  # commands to keep in memory
SAVEHIST=100000   # commands to save to file
HISTFILE=~/.zsh_history
export EDITOR=nvim

# TODO: split apploft specific config to separate zsh file
[[ -f ~/.config/apploft.zsh ]] && source ~/.config/apploft.zsh

# directory
alias /="cd /"
alias ~="cd"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

# general
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias zshcfg="nvim ~/.zshrc"
alias nvimcfg="nvim ~/.config/nvim/init.lua"
alias vim="nvim"
alias l='lsd -l'
alias ll='lsd -latr'
alias lt='lsd --tree'
alias cdl='cd ~/lotto/frontend/'

# git
alias g='git'
alias ga='git add'
alias gaa='git add --all'
alias gco='git checkout'
alias gf='git fetch'
alias glo='git log --oneline --decorate'
alias gl='git pull'
alias gp='git push'
alias gpf='git push --force-with-lease'
alias gss='git status --short'
alias grb='git rebase -i HEAD~10'
alias gst='git status'
alias gstash='read msg\?"Stash message: " && git stash push -m "$msg" -u'
alias gs='git stash'
alias gb='git branch'
alias resetme='git add . && git commit -m "chore: reset me softly"'
alias odiff='git diff origin/$(git rev-parse --abbrev-ref HEAD)'
alias greseto='git fetch origin && git reset --hard origin/$(git branch --show-current)'

# search
alias nf='fzf -m --preview="bat --color=always {}" --bind "enter:become(nvim {+})"'
alias vf='fzf -m --preview="bat --color=always {}" --bind "enter:become(code {+})"'

# Count migration progress
alias vue-stats='echo "All Vue components:" $(rg --files --glob "**/*.vue" | wc -l) && echo "Migrated to Composition API:" $(rg "<script(\s+lang=\"ts\")?\s+setup|<script\s+setup(\s+lang=\"ts\")?>" --glob "**/*.vue" --count | wc -l)'
alias vue-migrate='comm -12 \
  <(rg -l "<script" --glob "**/*.vue" | sort) \
  <(rg --files --glob "**/*.vue" | grep -vFf <(rg -l "<script(\s+lang=\"ts\")?\s+setup|<script\s+setup(\s+lang=\"ts\")?>" --glob "**/*.vue") | sort) \
  | awk "{print NR, \$0}"'

# hack to bypass https://github.com/junegunn/fzf/issues/164
bindkey "ç" fzf-cd-widget

# for syncyarnlock
# export PATH="$PATH:$(yarn global bin)"

alias moveCommits='function _moveCommits() {
  # Check for unstaged changes
  if [[ -n $(git diff --stat) ]]; then
    echo "There are unstaged changes. Please commit or stash them before proceeding."
    return 1
  fi

  # Get the name of the current branch
  current_branch=$(git rev-parse --abbrev-ref HEAD)

  # Find the last commit that has been pushed
  last_pushed_commit=$(git rev-parse @{u})

  # Ask for the new branch name
  echo "Enter the new branch name:"
  read new_branch

  # Create a new branch from the current branch
  git checkout -b $new_branch

  # Switch back to the original branch
  git checkout $current_branch

  # Reset the original branch to the last pushed commit
  git reset --hard $last_pushed_commit

  # Checkout new branch
  git checkout $new_branch
}; _moveCommits'
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"

export JIRA_PAT=$(security find-generic-password -a "$USER" -s "jira_pat" -w 2>/dev/null)
# TLN: get Jira release tickets
tln-release-tickets() {
  local PROJECT="$1"
  local VERSION="$2"
  if [[ -z "$PROJECT" || -z "$VERSION" ]]; then
    echo "Usage: tln-release-tickets <PROJECT_KEY> <VERSION_NAME>"
    return 1
  fi
  
  local JQL
  JQL=$(jq -rn --arg p "$PROJECT" --arg v "$VERSION" \
    '"project=" + $p + " AND fixVersion=\"" + $v + "\"" | @uri')
  
  local RESPONSE
  RESPONSE=$(curl -s \
    -H "Authorization: Bearer $JIRA_PAT" \
    "https://jira.tln-hannover.de/rest/api/2/search?jql=$JQL")
  
  local TOTAL
  TOTAL=$(printf '%s' "$RESPONSE" | jq '.issues | length')
  
  if [[ -z "$TOTAL" ]]; then
    echo "Error: Invalid response from Jira API"
    printf '%s' "$RESPONSE" | head -c 500
    return 1
  fi
  
  echo "----------------------"
  echo "Project: $PROJECT"
  echo "Fix Version: $VERSION"
  echo "Total issues: $TOTAL"
  echo "----------------------"
  echo ""
  echo "Web Frontend Release $VERSION"
  echo ""
  echo "Hallo zusammen,"
  echo ""
  echo "soeben wurde die Version $VERSION von $PROJECT auf der Produktiv-Umgebung bereitgestellt."
  echo "Das Release beinhaltet folgende Änderungen:"
  echo ""
  printf '%s' "$RESPONSE" | jq -r '
    .issues 
    | sort_by(.key | split("-")[1] | tonumber)
    | .[] 
    | "\(.key):\t\(.fields.summary)"
  ' | column -t -s $'\t'
  echo ""
  echo "Viele Grüße aus dem FE-Team"
  echo ""
}

# to use gawk as "awk", you can add a "gnubin" directory
PATH="/opt/homebrew/opt/gawk/libexec/gnubin:$PATH"

# If you need to have mysql-client@8.0 first in your PATH, run:
export PATH="/opt/homebrew/opt/mysql-client@8.0/bin:$PATH"

# For compilers to find mysql-client@8.0 you may need to set:
export LDFLAGS="-L/opt/homebrew/opt/mysql-client@8.0/lib"
export CPPFLAGS="-I/opt/homebrew/opt/mysql-client@8.0/include"

# tmux
if command -v tmux &> /dev/null && [[ -z "$TMUX" ]] && [[ $- == *i* ]]; then
  tmux new-session
fi

# init starship
eval "$(starship init zsh)"

# add plugins
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-history-substring-search/zsh-history-substring-search.zsh
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# enable git auto complete
autoload -Uz compinit && compinit
source <(kubectl completion zsh)

# fzf 
# fzf parameters used in all widgets - configure layout and wrapped the preview results (useful in large command rendering)
export FZF_DEFAULT_OPTS="--height 100% --layout reverse --preview-window=wrap"
# CTRL + R: put the selected history command in the preview window - "{}" will be replaced by item selected in fzf execution runtime
export FZF_CTRL_R_OPTS="--preview 'echo {}'"
# CTRL + T: set "fd-find" as search engine instead of "find" and exclude .git for the results
export FZF_CTRL_T_COMMAND="fd --exclude .git --ignore-file $HOME/.my-custom-zsh/.fd-fzf-ignore"
# CTRL + T: put the file content if item select is a file, or put tree command output if item selected is directory
export FZF_CTRL_T_OPTS="--preview '[ -d {} ] && tree -C {} || bat --color=always --style=numbers {}'"
export FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8 \
--color=selected-bg:#45475a \
--multi"
eval "$(fzf --zsh)"

. "$HOME/.local/bin/env"
eval "$("$HOME/.local/bin/mise" activate zsh)"
export PATH="$HOME/.volta/bin:$PATH"
export PATH="$HOME/.opencode/bin:$PATH"

