# encoding
export PYTHONIOENCODING=utf-8
export EDITOR='nvim'
export LC_ALL=en_US.UTF-8

# GPG
export GPG_TTY=$(tty)

# starship
source <(/usr/local/bin/starship init zsh --print-full-init)

# Alias
alias sessions="tmux attach -t test"
alias ll="exa -l -g --icons"
alias ls="exa --icons"
alias gpl="git pull"
alias ga="git add"
alias gc="git commit"
alias gco="git checkout"
alias gcp="git cherry-pick"
alias gdiff="git diff"
alias gl="git prettylog"
alias gp="git push"
alias gs="git status"
alias gt="git tag"
alias k="kubectl"
alias q="exit"

# bob
BOB_PREFIX="$HOME"/.bob-nvim
BOB_NVIM_BIN="$HOME"/.local/share/bob/nvim-bin
export PATH=$BOB_PREFIX:$BOB_NVIM_BIN:$PATH

# n
export N_PREFIX="$HOME/n"; [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"

# Key binding
bindkey -e
bindkey "jj" clear-screen

# Search cmd history and git repos
if (( $+commands[peco] )); then
	ZSH_PECO_HISTORY_OPTS="--layout=bottom-up --initial-filter=Fuzzy"
	ZSH_PECO_HISTORY_DEDUP="True"
	if ! (( ${+ZSH_PECO_HISTORY_OPTS} )); then
		ZSH_PECO_HISTORY_OPTS="--layout=bottom-up"
	fi
	
	function peco_select_history() {
		local parse_cmd
		
		if (( $+commands[gtac] )); then
			parse_cmd="gtac"
		elif (( $+commands[tac] )); then
			parse_cmd="tac"
		else
			parse_cmd="tail -r"
		fi
		
		if [ -n "$ZSH_PECO_HISTORY_DEDUP" ]; then
			if (( $+commands[perl] )); then
				parse_cmd="$parse_cmd | perl -ne 'print unless \$seen{\$_}++'"
			elif (( $+commands[awk] )); then
				parse_cmd="$parse_cmd | awk '!seen[\$0]++'"
			else
				parse_cmd="$parse_cmd | uniq"
			fi
		fi
		
		BUFFER=$(fc -l -n 1 | eval $parse_cmd | peco ${=ZSH_PECO_HISTORY_OPTS} --query "$LBUFFER")
		
		CURSOR=$#BUFFER # move cursor
		zle -R -c       # refresh
	}
	
	zle -N peco_select_history
	bindkey '^R' peco_select_history
fi

