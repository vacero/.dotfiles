# .zshrc
ZSH_BASE=$HOME/.dotfiles # Base directory for ZSH configuration

source $ZSH_BASE/antigen/antigen.zsh # Load Antigen

source ~/.aliases # Source some extra files
source ~/.functions

antigen use oh-my-zsh # Yes, I want to use Oh My ZSH

# Terminal stuff
antigen bundle git
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-history-substring-search
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle z

# Node stuff
antigen bundle node
antigen bundle npm

# Do OS dependant stuff
case `uname` in
  Darwin)
    # Commands for OS X go here
    antigen bundle osx
  ;;
  Linux)
    # Commands for Linux go here
  ;;
esac

# Set the theme
antigen theme theunraveler

# And lastly, apply the Antigen stuff
antigen apply


