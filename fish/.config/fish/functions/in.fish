function in
    if test -f $argv[1]
        if [ (printf $argv[1] | awk -F . '{print $NF}') = 'flatpak' ]
            flatpak install $argv
        else
            sudo pacman -U $argv
        end
    else
        yay -S $argv
    end
end
