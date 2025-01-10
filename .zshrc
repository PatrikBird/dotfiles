# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# plugins=(git gitignore docker docker-compose rails) 

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
#alias vim="nvim"
alias l='lsd -l'
alias ll='lsd -la'
alias lt='lsd --tree'
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
alias gst='git status'
alias gss='git status --short'

alias webup='cd ~/GitHub/website/ && code . &&  open -a Arc http://localhost:3000/ && pnpm dev'
alias estiup='cd ~/GitHub/esti/ && code . &&  open -a Arc http://localhost:5173/ && pnpm dev'
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
alias calmp='cd ~/GitLab/registration/'
alias calmc='code ~/GitLab/registration/'
alias calmup='calmp && docker compose up -d'
alias calmdown='calmp && docker compose down'
alias calmpostgres='docker exec --user=postgres -it calm-postgres sh'

export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"

export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

# pnpm
export PNPM_HOME="/Users/bird/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"
# pnpm end


# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/bird/Downloads/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/bird/Downloads/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/bird/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/bird/Downloads/google-cloud-sdk/completion.zsh.inc'; fi

# Created by `pipx` on 2024-12-12 10:17:45
export PATH="$PATH:/Users/bird/.local/bin"

eval "$(starship init zsh)"

# add plugins
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-history-substring-search/zsh-history-substring-search.zsh
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
