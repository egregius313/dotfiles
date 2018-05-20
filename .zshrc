# PATH
path+=(
	~/.local/bin/
	~/.cargo/bin/
)


source ~/antigen.zsh

antigen use oh-my-zsh


antigen theme https://github.com/caiogondim/bullet-train-oh-my-zsh-theme bullet-train
BULLETTRAIN_PROMPT_CHAR="⌘ "
BULLETTRAIN_TIME_BG="black"
BULLETTRAIN_TIME_FG="white"
BULLETTRAIN_GIT_DIRTY="%F{red} ✖%F{black}"
BULLETTRAIN_GIT_CLEAN="%F{green} ✔ %F{black}"
BULLETTRAIN_GIT_MODIFIED="%F{blue} ✱%F{black}"
BULLETTRAIN_GIT_UNTRACKED="%F{yellow} ❖%F{black}"
BULLETTRAIN_PROMPT_ORDER=(
  time
  dir
  git
  cmd_exec_time
)

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
antigen bundle git
antigen bundle lein
antigen bundle npm
antigen bundle nvm
antigen bundle pip
antigen bundle python
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-completions

antigen apply

[[ -f ~/.profile ]] && source ~/.profile
