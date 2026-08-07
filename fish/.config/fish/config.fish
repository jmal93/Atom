if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -x ZSH "$HOME/.oh-my-zsh"
set -x PYENV_ROOT "$HOME/.pyenv"
set -x RUSTFLAGS "-Cinstrument-coverage"
set -x LLVM_PROFILE_FILE "coverage.profraw"
set -x EDITOR "nvim"
set -x PATH "$PYENV_ROOT/bin:$PATH"
set -x PATH "$HOME/.tmuxifier/bin:$PATH"
set -x PATH "$HOME/.local/bin:$PATH"
set -x PATH "$HOME:/home/jao/.dotnet/tools:$PATH"
set -x PATH "/usr/lib/qt6/bin:$PATH"
set -x PATH "/usr/lib/python3.13:$PATH"
set -x PATH "$HOME/Documents/flutter/flutter/bin:$PATH"

# pyenv
set -Ux PYENV_ROOT $HOME/.pyenv
fish_add_path $PYENV_ROOT/bin
pyenv init - | source

alias sus="systemctl suspend & hyprlock -q"
alias pwroff="systemctl poweroff"
alias list-pkg="yay -Qqe | less"

# function fish_prompt
#     echo (set_color red) foo
# end

zoxide init fish | source

# pnpm
set -gx PNPM_HOME "/home/jao/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end
