#!/usr/bin/env sh
# Author: javy liu
#Date & Time: 2017-09-29 18:00
#Description: use this create a base shell script

if [[ -n "$1" ]]; then
  newfile=$1
else
  newfile=`pwd`/newscript_`date +%m%d_%S`
fi

if ! grep "^#!" $newfile &>/dev/null; then
  cat >> $newfile << EOF
#!/usr/bin/env sh
# Author: javy liu
#Date & Time: `date +"%F %T"`
#Description: $2

EOF
fi

vim +5 $newfile

