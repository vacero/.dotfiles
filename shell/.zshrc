# .zshrc
export TERM="xterm-256color"
ZSH_BASE=$HOME/.dotfiles # Base directory for ZSH configuration

POWERLEVEL9K_INSTALLATION_PATH=$ANTIGEN_BUNDLES/bhilburn/powerlevel9k
POWERLEVEL9K_MODE='nerdfont-complete'
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context dir rbenv vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(command_execution_time status root_indicator background_jobs history time)

source $ZSH_BASE/antigen/antigen.zsh # Load Antigen

source ~/.aliases # Source some extra files
source ~/.functions

antigen use oh-my-zsh # Yes, I want to use Oh My ZSH

# Terminal stuff
antigen bundle git
antigen bundle zdharma/zsh-diff-so-fancy
antigen bundle zdharma/fast-syntax-highlighting
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
antigen theme bhilburn/powerlevel9k powerlevel9k

# And lastly, apply the Antigen stuff
antigen apply



# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/vacero/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/vacero/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/vacero/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/vacero/google-cloud-sdk/completion.zsh.inc'; fi

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/Users/vacero/.sdkman"
[[ -s "/Users/vacero/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/vacero/.sdkman/bin/sdkman-init.sh"
