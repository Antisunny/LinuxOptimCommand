function lz() {
    function du_dir() {
        echo -e "\033[01;33m$1\033[00m" # $((RANDOM%6+1))
        (cd $1; ls -1 2>/dev/null | sed -e 's/^/"/' -e 's/$/"/'| xargs du -h -d 0 2>/dev/null)
    }
    function du_file() {
        (ls -lha $1 | awk '{print $5,$9}')
    }
    function getpath() { # support . and .. as the special path
            cd $1
            echo `pwd`
    }
    function usage(){
        echo -e " \033[01;37musage:\033[00m le [dir]/[file] ..."
        echo " if no arguement is given, 'lz' will print the current working dir"
        echo " .(current dir), ..(parent dir), *(metachar) are supported"
        echo -e "\n -V/-h for this help page"
        echo -e " \n--------------------------------------------------\n lz v0.1 by Ray Lee - March 30, 2015"
        echo -e " updates:\n  1.clone 'le' as 'lz', new feature added\n  2.empty parameter doesn't work"
        echo -e " ^\n lz v0.2 by Ray Lee - may 28, 2015"
        echo -e " updates: \n  1.make the empty arg work, printing the current directory\n  2.-V and -h works\n  3.add comments for code block\n  4.modify the help page"
    }
    default='.'
    args=($@)
    if [[ ${#args[@]} -gt 1 ]]; then
        ## the * meta means all the things in the current directory, length of it is gt 1 when current dir contains
        ## more than 1 thing, 1 if there is only one thing, le 1 when empty
        ## 
        for each in ${args[@]}; do
            [ -d $each ] && du_dir `getpath $each` || du_file `getpath $each`
        done
    elif [  ! -z $1 ]; then
        ## The oddness of the -d option for file test is that it recognises the empty as a directory
        ## So the -z should be used to make -d solid for empty args.
        ## 
        if [ -d $1 ]; then # support . and .. as the special path
            du_dir `getpath $1`
        elif [[ $1 == '-V' ]]; then
            usage
        elif [[ $1 == '-h' ]]; then
            usage
        fi
    else
        du_dir `getpath "."`
    fi
}
