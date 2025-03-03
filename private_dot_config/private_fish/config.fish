set fish_greeting

alias vi=nvim
alias vim=nvim

alias gr='cd (git rev-parse --show-toplevel)'

alias ip='ip -c'

abbr che chezmoi

set -x EDITOR nvim
set -x VISUAL nvim
set -x MANPAGER 'nvim +Man!'

set -x CMAKE_COLOR_DIAGNOSTICS ON
set -x CMAKE_EXPORT_COMPILE_COMMANDS ON
set -x CMAKE_GENERATOR "Ninja Multi-Config"

function try_fish_add_path
	if test -d $argv[1]
		fish_add_path $argv[1]
	end
end

fish_add_path $HOME/.local/bin
try_fish_add_path $HOME/.cargo/bin

starship init fish | source
zoxide init fish | source
zellij setup --generate-completion fish | source

## pyenv setting, not currently in use
# set -Ux PYENV_ROOT $HOME/.pyenv
# set -U fish_user_paths $PYENV_ROOT/bin $fish_user_paths
# setup pyenv
# pyenv init - | source

if command -q eza
    alias ll='eza -l --group-directories-first'
    alias la='eza -Al --group-directories-first'
    alias ls='eza'
    alias ld='eza -d .* --group-directories-first'
    alias lt='eza --tree'
else
    alias ll='ls -l --group-directories-first'
    alias la='ls -Al --group-directories-first'
    alias ld='ls -d .* --group-directories-first'
    alias lt='tree'
end
