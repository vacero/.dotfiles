# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export TERM="xterm-256color"
ZSH_BASE=$HOME/.dotfiles # Base directory for ZSH configuration

DEFAULT_USER=vacero

source $ZSH_BASE/antigen/antigen.zsh # Load Antigen

source ~/.aliases # Source some extra files
source ~/.functions

antigen use oh-my-zsh # Yes, I want to use Oh My ZSH

# Terminal stuff
antigen bundle git
antigen bundle zdharma/zsh-diff-so-fancy
antigen bundle zdharma-continuum/fast-syntax-highlighting
antigen bundle zsh-users/zsh-history-substring-search
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle dashixiong91/zsh-vscode
antigen bundle b4b4r07/emoji-cli
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
antigen theme romkatv/powerlevel10k

# And lastly, apply the Antigen stuff
antigen apply

### Fix slowness of pastes with zsh-syntax-highlighting.zsh
pasteinit() {
  OLD_SELF_INSERT=${${(s.:.)widgets[self-insert]}[2,3]}
  zle -N self-insert url-quote-magic # I wonder if you'd need `.url-quote-magic`?
}

pastefinish() {
  zle -N self-insert $OLD_SELF_INSERT
}
zstyle :bracketed-paste-magic paste-init pasteinit
zstyle :bracketed-paste-magic paste-finish pastefinish
### Fix slowness of pastes


# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/vacero/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/vacero/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/vacero/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/vacero/google-cloud-sdk/completion.zsh.inc'; fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# AIR TOOLS
export SPACEPORT_DIR=~/projects/spaceport
export PATH=${SPACEPORT_DIR}/sh/:$PATH
alias air-deploy=air-deploy.sh


#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/Users/vacero/.sdkman"
[[ -s "/Users/vacero/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/vacero/.sdkman/bin/sdkman-init.sh"

[[ /Users/vacero/google-cloud-sdk/bin/kubectl ]] && source <(kubectl completion zsh)

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

eval $(thefuck --alias)
