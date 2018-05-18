# PATH
path+=(
	~/.local/bin/
	~/.cargo/bin/
)


source ~/antigen.zsh

antigen use oh-my-zsh

antigen bundle git


# When running on a Mac
[[ "`uname`" == Darwin ]] && NAME=macOS

[[ -f /etc/os-release ]] && source /etc/os-release
case $NAME in
	"Arch Linux")
		antigen bundle archlinux
		;;
	*SUSE*)
		antigen bundle suse
		;;
	macOS)
		antigen bundle osx
		antigen bundle brew
		;;
	*)
		which apt 1>/dev/null && antigen bundle debian
		;;
esac


antigen bundle colored-man-pages
antigen bundle copybuffer
antigen bundle dircycle

antigen bundle python
antigen bundle pip
antigen bundle nvm
antigen bundle npm

antigen apply
