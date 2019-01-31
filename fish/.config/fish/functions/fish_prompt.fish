# Options
set __fish_git_prompt_show_informative_status
set __fish_git_prompt_showcolorhints
set __fish_git_prompt_showupstream "informative"
set __fish_git_prompt_char_stateseparator " "
set __fish_git_prompt_char_cleanstate ""

# Colors
set -l green 64FE00
set -l grey B5B5B5
set -l red FF000D
set -l yellow FFCF33

set __fish_git_prompt_color_branch white --bold
set __fish_git_prompt_color_branch_detached $red
set __fish_git_prompt_color_dirtystate white
set __fish_git_prompt_color_invalidstate $red
set __fish_git_prompt_color_merging $yellow
set __fish_git_prompt_color_stagedstate $yellow
set __fish_git_prompt_color_untrackedfiles $grey
set __fish_git_prompt_color_upstream_ahead $green
set __fish_git_prompt_color_upstream_behind $red

function fish_prompt
    set -l _last_status $status
    set -l _git_prompt (__fish_git_prompt)

    if [ "$TERM" = "linux" ]
        set ssh [ssh]
        set arrow \U002D\U003E
    else
        set ssh \U26A1
        set arrow \U279C
    end

    [ $_last_status -gt 0 ] && [ $CMD_DURATION -gt 0 ] && printf "%s\n" "[$_last_status]"
    set -q SSH_CLIENT || set -q SSH_CONNECTION || set -q SSH_TTY && printf "%s" "$ssh "
    set_color FF3366
    printf "%s" (basename (prompt_pwd))
    if [ $_git_prompt ]
        set_color 3366FF
        printf "%s" ":"
        set_color normal
        printf "%s" $_git_prompt | sed -n 's/^ (\(.*[^ ]\)[ ]\?)$/\1/p'
    end
    set_color normal
    printf " %s " "$arrow"
end
