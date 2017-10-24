#!/bin/sh

#  /**************************************************************************/
#  /*                                                                        */
#  /*  Licensed Materials - Property of HCL                                  */
#  /*                                                                        */
#  /*  HCL Informix                                                          */
#  /*  (c) Copyright HCL Technologies Ltd. 2017.  All Rights Reserved.       */
#  /*                                                                        */
#  /**************************************************************************/
#
#  Name        : do_mart.sh
#  Created     : September 2017
#  Description : Utility to manage data marts in the
#                Informix Warehouse Accelerator
#
#  Usage       :
#     do_mart.sh { -drop <mart name> | -create <xml file> | -load <mart name> | -list } \
#                [-v] [ database ] [ accelerator ]
#       -drop : drop the data mart.
#       -create : create data mart using definition in XML file.
#       -load : load the data mart.
#       -list : list existing data marts.
#       -v : verbose output.
#       database: database to connect to. Default: iwadb
#       accelerator: accelerator to use. Default: iwa1
#

mydb=iwadb
myiwa=iwa1

command=0  # 0: usage, 1: drop, 2: create, 3: load, 4: list
verbose=0
dbaccv=''
err=''

if [ "x$1" = "x-drop" ]; then
  command=1
  mart=$2
  if [ "x${mart}" = "x" ]; then
    err="Error: drop mart command needs a data mart name."
  fi
  shift; shift
fi

if [ "x$1" = "x-create" ]; then
  command=2
  xml=$2
  if [ "x${xml}" = "x" ]; then
    err="Error: create mart command needs an XML file name."
  fi

  shift; shift
fi

if [ "x$1" = "x-load" ]; then
  command=3
  mart=$2
  if [ "x${mart}" = "x" ]; then
    err="Error: load mart command needs a data mart name."
  fi

  shift; shift
fi

if [ "x$1" = "x-list" ]; then
  command=4
  shift
fi

if [ "x$1" = "x-v" ]; then
  verbose=1
  dbaccv='-e'
  shift
fi

if [ "x$1" != "x" ]; then
  mydb=$1
  shift
fi

if [ "x$1" != "x" ]; then
  myiwa=$1
  shift
fi


if [ "x${err}" != "x" ]; then
  echo "${err}"
  echo " "
  command=0
fi

if [ ${command} -eq 0 ]; then
  echo "Usage: $0 { -drop <mart name> | -create <xml file> | -load <mart name> | -list } [-v] [ database ] [ accelerator ]"
  echo "  -drop : drop the data mart."
  echo "  -create : create data mart using definition in XML file."
  echo "  -load : load the data mart."
  echo "  -list : list existing data marts."
  echo "  -v : verbose output."
  echo "  database: database to connect to. Default: iwadb"
  echo "  accelerator: accelerator to use. Default: iwa1"
  exit 0
fi

cat /dev/null > mytmp.$$.sql

if [ ${command} -eq 1 ]; then
cat > mytmp.$$.sql << EOS
execute function ifx_dropMart('${myiwa}', '${mart}');
EOS
fi

if [ ${command} -eq 2 ]; then
cat > mytmp.$$.sql << EOS
execute function ifx_createMart('${myiwa}', filetoclob('${xml}', 'client'));
EOS
fi

if [ ${command} -eq 3 ]; then
cat > mytmp.$$.sql << EOS
execute function ifx_loadMart('${myiwa}', '${mart}', 'NONE');
EOS
fi

if [ ${command} -eq 4 ]; then
cat > mytmp.$$.sql << EOS
execute function ifx_listMarts('${myiwa}');
EOS
fi

if [ ${verbose} -gt 0 ]; then
  echo "Connecting to database ${mydb} and using accelerator ${myiwa}."
fi

cat mytmp.$$.sql \
  | dbaccess ${dbaccv} ${mydb} - 2>&1 \
  | egrep -v '^$|^Database selected\.$|^Database closed\.$'

rm -f mytmp.$$.sql

exit
