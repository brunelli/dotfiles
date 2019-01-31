if status is-login
    set -gx CM_DIR ~/.local/share/
    set -gx EDITOR vim
    set -gx fish_user_paths $fish_user_paths ~/.local/bin 
    set -gx KITTY_ENABLE_WAYLAND 1
    set -gx QT_WAYLAND_DISABLE_WINDOWDECORATION 1
    set -gx SSH_AGENT_PID ''
    set -gx SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)
    set -gx XKB_DEFAULT_LAYOUT br
    set -gx XKB_DEFAULT_MODEL abnt2
    set -gx XKB_DEFAULT_VARIANT abnt2 
    if not pidof -x tbsm > /dev/null
        tbsm qm
    end
end
