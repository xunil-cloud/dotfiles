set fish_greeting

alias vi=nvim
alias vim=nvim
abbr che chezmoi

set -x EDITOR nvim
set -x VISUAL nvim

source $HOME/.cargo/env.fish

if test -d $HOME/nvim-linux64/bin
	fish_add_path $HOME/nvim-linux/bin
end

fish_add_path $HOME/.local/bin

starship init fish | source
zoxide init fish | source
zellij setup --generate-completion fish | source

## pyenv setting, not currently in use

# set -Ux PYENV_ROOT $HOME/.pyenv
# set -U fish_user_paths $PYENV_ROOT/bin $fish_user_paths
# setup pyenv
# pyenv init - | source
