function up
    echo ":: Upgrading system packages"
    apt-get update &&
    apt-get upgrade
    echo ":: Upgrading pip packages"
    set upip (pip list --outdated --format json 2> /dev/null | awk -F'"' '{for(i=1;i<=NF;i++){if($i=="name"){NAME=i+2; printf $NAME" "}}}')
    if [ $upip ]
        pip install --upgrade $upip
    else
        echo "Nothing to upgrade."
    end
end
