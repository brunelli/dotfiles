function up
    echo ":: Upgrading system packages"
    pkg upgrade
    echo ":: Upgrading pip packages"
    set upip (pip list --outdated --format json 2> /dev/null | awk -F'"' '{for(i=1;i<=NF;i++){if($i=="name"){NAME=i+2; printf "%s " $NAME}}}')
    if test -n "$upip"
        printf "%s" $upip | xargs pip install --upgrade
    else
        echo "Nothing to upgrade."
    end
end
