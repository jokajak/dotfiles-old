#       _           _  _          __
#  ___ | |__   ___ | || |        / _| _   _      ___  _ __  __ _
# / __|| '_ \ / _ \| || | _____ | |_ | | | |    / _ \| '__|/ _` |
# \__ \| | | |  __/| || ||_____||  _|| |_| | _ | (_) | |  | (_| |
# |___/|_| |_|\___||_||_|       |_|   \__,_|(_) \___/|_|   \__, |
#                                                   .bashrc|___/
#
# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# cdpath - http://www.shell-fu.org/lister.php?id=185
export CDPATH='.:~'


# directory tree - http://www.shell-fu.org/lister.php?id=209
#alias dirf='find . -type d | sed -e "s/[^-][^\/]*\//  |/g" -e "s/|\([^ ]\)/|-\1/"'


#compare files using comm (requires perl) - http://www.shell-fu.org/lister.php?id=186
compare(){
  comm $1 $2 | perl -pe 's/^/1: /g;s/1: \t/2: /g;s/2: \t/A: /g;' | sort
}


#calendar with today highlighted - http://www.shell-fu.org/lister.php?id=210
alias tcal='cal | sed "s/^/ /;s/$/ /;s/ $(date +%e) / $(date +%e | sed '\''s/./#/g'\'') /"'


# count files by type - http://www.shell-fu.org/lister.php?id=173
alias ftype='find ${*-.} -type f | xargs file | awk -F, '\''{print $1}'\'' | awk '\''{$1=NULL;print $0}'\'' | sort | uniq -c | sort -nr'


# convert permissions to octal - http://www.shell-fu.org/lister.php?id=205
alias lo='ls -l | sed -e 's/--x/1/g' -e 's/-w-/2/g' -e 's/-wx/3/g' -e 's/r--/4/g' -e 's/r-x/5/g' -e 's/rw-/6/g' -e 's/rwx/7/g' -e 's/---/0/g''


# portscan in one line - http://www.shell-fu.org/lister.php?id=295
portscan(){
  HOST="$1";for((port=1;port<=65535;++port));do echo -en "$port ";if echo -en "open $HOST $port\nlogout\quit" | telnet 2>/dev/null | grep 'Connected to' > /dev/null;then echo -en "\n\nport $port/tcp is open\n\n";fi;done
}


# print a random shell-fu tip - http://www.shell-fu.org/lister.php?id=192
#alias shell-fu='links -dump "http://www.shell-fu.org/lister.php?random" | grep -A 100 -- ----'


# get an ordered list of subdirectory sizes - http://www.shell-fu.org/lister.php?id=275
alias dux='du -sk ./* | sort -n | awk '\''BEGIN{ pref[1]="K"; pref[2]="M"; pref[3]="G";} { total = total + $1; x = $1; y = 1; while( x > 1024 ) { x = (x + 1023)/1024; y++; } printf("%g%s\t%s\n",int(x*10)/10,pref[y],$2); } END { y = 1; while( total > 1024 ) { total = (total + 1023)/1024; y++; } printf("Total: %g%s\n",int(total*10)/10,pref[y]); }'\'''


# overwrite a file with zeroes - http://www.shell-fu.org/lister.php?id=94
zero() {
  case "$1" in
    "")     echo "Usage: zero <file>"
            return -1;
  esac
  filesize=`wc -c  "$1" | awk '{print $1}'`
  dd if=/dev/zero of=$1 count=$filesize bs=1
}


# keep your home directory organised - http://www.shell-fu.org/lister.php?id=310
if [ -d $HOME/temp/`date +'%Y-%m-%d'` ]; then
	ln -sfn $HOME/temp/`date +'%Y-%m-%d'` $HOME/today
fi
td(){
    td="$HOME/temp/`date +'%Y'`/`date '+%m'`/`date '+%d'`"
    if [ ! -z "$1" ]; then
        YEAR=`date -d "$1 days" '+%Y'`
        MONTH=`date -d "$1 days" '+%m'`
        DAY=`date -d "$1 days" '+%d'`
        td="$HOME/temp/$YEAR/$MONTH/$DAY"
    fi
    mkdir -p $td; cd $td
    if [ -z "$1" ]; then
        ln -sfn $td $HOME/today
    fi
    unset td
}
btd(){
    td="/mnt/user/burns/`date +'%Y-%m-%d'`"
    if [ ! -z "$1" ]; then
        td="/mnt/user/burns/`date -d "$1 days" +'%Y-%m-%d'`";
    fi
    mkdir -p $td; cd $td
    unset td
}


# create a terminal calculator - http://www.shell-fu.org/lister.php?id=216
#calc(){ echo "${1}"|bc -l; }


# copy and paste from the command line - http://www.shell-fu.org/lister.php?id=177
#ccopy(){ cp $1 /tmp/ccopy.$1; }
#alias cpaste="ls /tmp/ccopy* | sed 's|[^\.]*.\.||' | xargs -I % mv /tmp/ccopy.% ./%"


# bash function to decompress archives - http://www.shell-fu.org/lister.php?id=375
extract () {
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)   tar xvjf $1        ;;
            *.tar.gz)    tar xvzf $1     ;;
            *.bz2)       bunzip2 $1       ;;
            *.rar)       unrar x $1     ;;
            *.gz)        gunzip $1     ;;
            *.tar)       tar xvf $1        ;;
            *.tbz2)      tar xvjf $1      ;;
            *.tgz)       tar xvzf $1       ;;
            *.zip)       unzip $1     ;;
            *.Z)         uncompress $1  ;;
            *.7z)        7z x $1    ;;
            *)           echo "'$1' cannot be extracted via >extract<" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}


######################### Additional Aliases #########################
alias l='ls -alF'
alias ll='ls -alF'
alias dir='ls -la'
alias la='ls -Fa'
alias ld='ls -al -d * | egrep "^d"' # only subdirectories
alias lt='ls -alt | head -20' # recently changed files

alias md='mkdir -p'
alias ..='cd ..'
alias ...='cd ../..'
alias +='pushd .'

########################## Pretty Ram ################################
drawChart() {
	COUNT=0
	MAX=30
	CHARTWIDTH=`expr $MAX - 2`
	CHARTUSED=`expr $2 '*' $MAX / $1`
	CHARTFREE=`expr $CHARTWIDTH - $CHARTUSED`
	echo -n "["
	while [ $COUNT -lt $MAX ] ; do
		if [ $COUNT -lt $CHARTUSED ]; then
			echo -n "#"
		else
			echo -n "."
		fi
		COUNT=`expr $COUNT + 1`
	done
	echo "] ($3% occupied)"
}
memfree() {
	RAM=`free -m | grep Mem`
	SWAP=`free -m | grep Swap`
	RAMTOTAL=`echo $RAM | awk '{ print $2 }'`
	RAMUSED=`echo $RAM | awk '{ print $3 }'`
	SWAPTOTAL=`echo $SWAP | awk '{ print $2 }'`
	SWAPUSED=`echo $SWAP | awk '{ print $3 }'`
	RAMPERCENT=`expr 100 '*' $RAMUSED '/' $RAMTOTAL`
	SWAPPERCENT=`expr 100 '*' $SWAPUSED '/' $SWAPTOTAL`
	echo "RAM (total: $RAMTOTAL MB; used: $RAMUSED MB)"
	drawChart $RAMTOTAL $RAMUSED $RAMPERCENT
	echo
	echo "SWAP (total: $SWAPTOTAL MB; used: $SWAPUSED MB)"
	drawChart $SWAPTOTAL $SWAPUSED $SWAPPERCENT
}
excuse() {
	echo `telnet bofh.jeffballard.us 666 2>/dev/null` |grep --color -o "Your excuse is:.*$"
}
