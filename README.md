# Setup

Clone repo
```zsh
git clone --bare git@github.com:yourusername/dotfiles.git $HOME/.dotfiles
```

Create alias for managing the dotfiles
```zsh
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
```

Checkout the actual content from the repo
```zsh
config checkout
```

Get dotfiles with
```zsh
config pull
```
