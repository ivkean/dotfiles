# bash only
if [[ $BASH ]]; then
  # Case-insensitive globbing (used in pathname expansion)
  shopt -s nocaseglob

  # Check the window size after each command and, if necessary,
  # update the values of LINES and COLUMNS.
  shopt -s checkwinsize

  # enable programmable completion features (you don't need to enable
  # this, if it's already enabled in /etc/bash.bashrc and /etc/profile
  # sources /etc/bash.bashrc).
  if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
      . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
      . /etc/bash_completion
    fi
  fi
fi

# GREP_OPTIONS is deprecated, see:
# http://askubuntu.com/questions/2186/replace-grep-command-with-grep-n-colour/2189#2189
alias grep='grep --color=auto'

# Prevent less from clearing the screen while still showing colors.
export LESS=-XR

# Set the terminal's title bar.
function titlebar() {
  echo -n $'\e]0;'"$*"$'\a'
}

# SSH auto-completion based on entries in known_hosts.
if [[ -e ~/.ssh/known_hosts ]]; then
  complete -o default -W "$(cat ~/.ssh/known_hosts | sed 's/[, ].*//' | sort | uniq | grep -v '[0-9]')" ssh scp sftp
fi

# Disable ansible cows }:]
export ANSIBLE_NOCOWS=1

# On Ubuntu, changes default Alt+Click (which move windows) to Super+Click for VsCode
# multiple cursor selection.
# Ubuntu-only stuff. Abort if not Ubuntu.
is_ubuntu && gsettings set org.gnome.desktop.wm.preferences mouse-button-modifier "<Super>"
