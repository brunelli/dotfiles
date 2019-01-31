function fish_prompt
    if not set -q -g __fish_prompt_functions_defined
        set -g __fish_prompt_functions_defined

        function _git_branch_name
            git branch --no-color 2> /dev/null | sed -n "s/^\*[[:space:]]\(.*\)\$/\1/p"
        end

        function _git_dirty
            git status --porcelain --ignore-submodules=dirty 2> /dev/null | wc -l
        end

        function _git_staged
            git diff --cached --numstat 2> /dev/null | wc -l
        end

        function _prompt_format_number
            if [ $argv[1] -le 9 ]
            and [ "$TERM" != "linux" ]
                echo (set_color -o $argv[2] -b normal)$argv[1]\UFE0F\U20E3
            else
                echo (set_color -o FFFFFF -b $argv[2])$argv[1]
            end
        end
    end

    set -l normal_color (set_color normal -b normal)
    set -l git_branch_color (set_color -o FFFFFF -b normal)
    set -l colon_color (set_color -o 3366FF -b normal)
    set -l dir_name (set_color -o FF3366 -b normal)(basename (prompt_pwd))
    set -l git_branch_name (_git_branch_name)

    if [ "$TERM" = "linux" ]
        set -x arrow \U002D\U003E
    else
        set -x arrow \U279C
    end

    if [ "$git_branch_name" ]
        set -l git_branch $git_branch_color$git_branch_name
        set -x git_info $colon_color:$git_branch$normal_color
        set -x git_staged (_git_staged)
        set -x git_dirty (expr (_git_dirty) - $git_staged) # FIXME

        if [ (git branch -vv | grep "^* .*\[.*: ahead.*\].*\$") ]
            set git_info $git_info\*
        end

        if [ $git_staged -gt 0 ]
            set git_info $git_info (_prompt_format_number $git_staged 849900)
        end

        if [ $git_dirty -gt 0 ]
            set git_info $git_info (_prompt_format_number $git_dirty FF8A00)
        end
    end
    echo -n "$dir_name$git_info$normal_color $arrow "
end
