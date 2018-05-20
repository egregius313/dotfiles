function edit () {
    emacsclient -nc $@ --alternate-editor "";
}


# OPAM configuration
. /home/egregius313/.opam/opam-init/init.sh > /dev/null 2> /dev/null || true
