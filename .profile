export EDITOR="emacsclient -t"        # $EDITOR opens terminal Emacs
export VISUAL='emacsclient -c -a ""'  # $VISUAL opens GUI (without daemon as fallback)

function edit () {
    emacsclient -nc $@ --alternate-editor "";
}

alias ..='cd ..'
alias ...='cd ../..'

# OPAM configuration
. /home/egregius313/.opam/opam-init/init.sh > /dev/null 2> /dev/null || true
