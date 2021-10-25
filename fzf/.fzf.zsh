# Setup fzf
# ---------
if [[ ! "$PATH" == */usr/local/opt/fzf/bin* ]]; then
  export PATH="$PATH:/usr/local/opt/fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/usr/local/opt/fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/usr/local/opt/fzf/shell/key-bindings.zsh"


# GIT heart FZF
# -------------

is_in_git_repo() {
  [ -d .git ] || git rev-parse --git-dir > /dev/null 2>&1 || echo "This_is_not_a_git_repository"
}

fzf-down() {
  fzf --height 80% "$@" --border
}

FZF_PREFIX="fzf-git-"

function "${FZF_PREFIX}gf" () {
  is_in_git_repo || return
  git -c color.status=always status --short |
  fzf-down -m --ansi --nth 2..,.. \
    --preview '(git diff --color=always -- {-1} | sed 1,4d; cat {-1}) | head -500' |
  cut -c4- | sed 's/.* -> //'
}

function "${FZF_PREFIX}gb" () {
  is_in_git_repo || return
  git for-each-ref --sort=-committerdate refs/heads/ --format='%(if)%(HEAD)%(then)%(color:bold blue)%(else)%(color:yellow)%(end)%(refname:short)%(color:reset) - %(color:red)%(objectname:short)%(color:reset) - %(contents:subject) - %(authorname) (%(color:green)%(committerdate:relative)%(color:reset))' --color=always |
  fzf-down --ansi --no-sort | awk '{print $1}'
}

# git tag
function "${FZF_PREFIX}gt" () {
  is_in_git_repo || return
  git tag --sort -version:refname |
  fzf-down --multi --preview-window right:70% \
    --preview 'git show --color=always {} | head -'$LINES
}

function "${FZF_PREFIX}gh" () {
  is_in_git_repo || return
  git log --date=short --format="%C(green)%C(bold)%cd %C(auto)%h%d %s (%an)" --graph --color=always |
  fzf-down --ansi --no-sort --reverse --multi --bind 'ctrl-s:toggle-sort,pgup:preview-up,pgdn:preview-down' \
    --header 'Press CTRL-S to toggle sort' \
    --preview 'grep -o "[a-f0-9]\{7,\}" <<< {} | xargs git show --color=always' |
  grep -o "[a-f0-9]\{7,\}"
}

function "${FZF_PREFIX}gr" () {
  is_in_git_repo || return
  git remote -v | awk '{print $1 "\t" $2}' | uniq |
  fzf-down --tac \
    --preview 'git log --oneline --graph --date=short --pretty="format:%C(auto)%cd %h%d %s" {1} | head -200' |
  cut -d$'\t' -f1
}

function "${FZF_PREFIX}gs" () {
  is_in_git_repo || return
  git stash list --oneline --color=always |
  fzf-down --ansi --no-sort --reverse --bind 'ctrl-s:toggle-sort,pgup:preview-up,pgdn:preview-down' \
    --header 'Press CTRL-S to toggle sort' \
    --preview 'grep -o -m 1 "^[a-f0-9]\{7,\}" <<< {} | xargs git stash show --color=always | head -'$LINES |
  grep -o "refs/stash@{[0-9]*}"
}

join-lines() {
  local item
  while read item; do
    echo -n "${(q)item} "
  done
}

bind-git-helper() {
  local char
  for c in $@; do
    eval "fzf-g$c-widget() { local result=\$(${FZF_PREFIX}g$c | join-lines); zle reset-prompt; LBUFFER+=\$result }"
    eval "zle -N fzf-g$c-widget"
    eval "bindkey '^g^$c' fzf-g$c-widget"
  done
}
bind-git-helper f b t r h s
unset -f bind-git-helper



## COMPLETIONS
_fzf_complete_git() {
    ARGS="$@"
    local branches
    branches=$(git branch -vv --all)
    if [[ $ARGS == 'git co'* ]]; then
        _fzf_complete "--reverse --multi --ansi" "$@" < <(
            echo $branches
        )
    else
        eval "zle ${fzf_default_completion:-expand-or-complete}"
    fi
}

_fzf_complete_git_post() {
    awk '{print $1}'
}
