# export EDITOR="emacsclient -t"        # $EDITOR opens terminal Emacs
export VISUAL='emacsclient -c -a ""'  # $VISUAL opens GUI (without daemon as fallback)

function edit () {
    emacsclient -nc $@ --alternate-editor "";
}

alias ..='cd ..'
alias ...='cd ../..'


export EDITOR=exwm_edit

function dotemacs() {
    cd ~/.emacs.d
}

export PATH="$HOME/sucklessdownloads/bin:$PATH"
export PATH="$HOME/bin:$PATH"

export TERMINAL=st

[[ -f ~/.emacsaliases ]] && source ~/.emacsaliases

# OPAM configuration
. /home/egregius313/.opam/opam-init/init.sh > /dev/null 2> /dev/null || true
