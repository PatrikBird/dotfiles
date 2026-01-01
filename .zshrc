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
alias vim="nvim"
alias l='lsd -l'
alias ll='lsd -latr'
alias lt='lsd --tree'
alias cdl='cd '
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
alias grb='git rebase -i HEAD~10'
# search
alias nf='fzf -m --preview="bat --color=always {}" --bind "enter:become(nvim {+})"'
alias vf='fzf -m --preview="bat --color=always {}" --bind "enter:become(code {+})"'
# hack to bypass https://github.com/junegunn/fzf/issues/164
bindkey "ç" fzf-cd-widget

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

# tmux
if command -v tmux &> /dev/null && [[ -z "$TMUX" ]] && [[ $- == *i* ]]; then
  tmux new-session
fi

# starship prompt
eval "$(starship init zsh)"

# add plugins
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-history-substring-search/zsh-history-substring-search.zsh
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

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

# opencode
export PATH=/Users/bird/.opencode/bin:$PATH
