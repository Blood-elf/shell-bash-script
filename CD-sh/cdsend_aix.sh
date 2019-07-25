#!/bin/sh

# for the remote CD node of Linux
# transfer source file to target node

#---------------------------------------------------
# Usage for help
#
_Help()
{
cat <<!

Usage:
     sh cdsend_aix.sh <SNODE> <FILENAME> <SRCFILEDIR> <TAGFILEDIR>
exp:
     sh cdsend_aix.sh CS01P590A025 filename /home/afa/file/UNL/YGZ /home/afe

Param:
    <SNODE>         remote cdods node
    <FILENAME>      file name
    <SRCFILEDIR>    src path
    <TARFILEDIR>    target path

!

exit 21
}

echo "[$1][$2][$3][$4]"

# remote cdods node. exp:#"CS01P590A025"
SNODE=$1

FILENAME=$2
SRCFILEDIR=$3
TAGFILEDIR=$4

# check the total nunber of params
if [ $# -ne 4 ]
then
    echo "Params error."
          _Help
fi


echo  "M" "  Shell Name     : cdsend_aix.sh"
echo  "M" "  SNODE          : ${SNODE}"
echo  "M" "  FILENAME       : ${FILENAME}"
echo  "M" "  SRCFILEDIR     : ${SRCFILEDIR}"
echo  "M" "  TAGFILEDIR     : ${TAGFILEDIR}"


# CDDIR should to change to the right path!!!
CDDIR=/home/cdadmin/cdunix
NDMAPICFG=$CDDIR/ndm/cfg/cliapi/ndmapi.cfg
export NDMAPICFG

# execute the send task
if [ -e $SRCFILEDIR/${FILENAME} ]; then
$CDDIR/ndm/bin/direct -x << EOJ1
submit maxdelay=0 
CDTEST01 process snode=$SNODE
step1
  copy from (file=$SRCFILEDIR/${FILENAME} pnode)
     to   (file=$TAGFILEDIR/${FILENAME} snode disp=rpl)
pend;
quit;
EOJ1
else 
  echo "Source file not exsits."
  exit 2
fi

# result
SAVE=$?
if [[ $SAVE > 0 ]]
then echo $SAVE
     echo "Error occurred."
     exit 1
fi
echo "Send completed successfully."
exit 0
