# encoding
export PYTHONIOENCODING=utf-8
export EDITOR='nvim'
export LC_ALL=en_US.UTF-8

# homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# direnv
eval "$(direnv hook zsh)"

# GHQ root dir
export GHQ_ROOT=$HOME/development

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# goenv
export GOENV_ROOT="$HOME/.goenv"
export PATH="$GOENV_ROOT/bin:$PATH"
eval "$(goenv init -)"
export PATH="$GOROOT/bin:$PATH"
export PATH="$PATH:$GOPATH/bin"

# starship
source <(/opt/homebrew/bin/starship init zsh --print-full-init)

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


if (( $+commands[peco] )); then
	ZSH_PECO_GHQ_FILTER=${ZSH_PECO_GHQ_FILTER:-IgnoreCase}
	function zsh-peco-ghq () {
		local selected_dir=$(ghq list -p | peco --initial-filter "$ZSH_PECO_GHQ_FILTER" --query "$LBUFFER")
		if [ -n "$selected_dir" ]; then
			BUFFER="cd ${selected_dir}"
			zle accept-line
		fi
		zle clear-screen
	}
	
	zle -N zsh-peco-ghq
	bindkey '^f' zsh-peco-ghq
fi

