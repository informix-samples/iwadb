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
#  Name        : do_accel.sh
#  Created     : September 2017
#  Description : Utility to manage an accelerator in the
#                Informix Warehouse Accelerator
#
#  Usage       :
#     do_accel.sh { -remove <accelerator name> | \
#                   -setup <accelerator name> <IP address> <port number> <PIN> } \
#                [-v] [ database ]
#       -remove : remove an accelerator (from the sqlhosts file).
#       -setup  : setup connection to IWA and create new accelerator.
#       -v : verbose output.
#       database: database to connect to. Default: iwadb
#

mydb=iwadb

command=0  # 0: usage, 1: remove, 2: setup
verbose=0
dbaccv=''
err=''

if [ "x$1" = "x-remove" ]; then
  command=1
  accel=$2
  if [ "x${accel}" = "x" ]; then
    err="Error: remove accelerator command needs an accelerator name."
  fi
  shift; shift
fi

if [ "x$1" = "x-setup" ]; then
  command=2
  accel=$2
  if [ "x${accel}" = "x" ]; then
    err="Error: setup accelerator command needs an accelerator name."
  fi
  ip_addr=$3
  if [ "x${ip_addr}" = "x" ]; then
    err="Error: setup accelerator command needs an IP address."
  fi
  port_num=$4
  if [ "x${port_num}" = "x" ]; then
    err="Error: setup accelerator command needs a port number."
  fi
  pin=$5
  if [ "x${pin}" = "x" ]; then
    err="Error: setup accelerator command needs a four-digit PIN."
  fi

  shift ; shift ; shift ; shift ; shift
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


if [ "x${err}" != "x" ]; then
  echo "${err}"
  echo " "
  command=0
fi

if [ ${command} -eq 0 ]; then
  echo "Usage: $0 { -remove <accelerator name> | -setup <accelerator name> <IP address> <port number> <PIN> } [-v] [ database ]"
  echo "  -remove : remove an accelerator (from the sqlhosts file)."
  echo "  -setup  : setup connection to IWA and create new accelerator."
  echo "            A unique accelerator name must be chosen."
  echo "            IP address, port number and PIN as provided by \"ondwa getpin\"."
  echo "  -v : verbose output."
  echo "  database: database to connect to. Default: iwadb"
  exit 0
fi

cat /dev/null > mytmp.$$.sql

if [ ${command} -eq 1 ]; then
cat > mytmp.$$.sql << EOS
execute function ifx_removeDWA('${accel}');
EOS
fi

if [ ${command} -eq 2 ]; then
cat > mytmp.$$.sql << EOS
execute function ifx_setupDWA('${accel}', '${ip_addr}', '${port_num}', '${pin}');
EOS
fi

if [ ${verbose} -gt 0 ]; then
  echo "Connecting to database ${mydb}."
fi

cat mytmp.$$.sql \
  | dbaccess ${dbaccv} ${mydb} - 2>&1 \
  | egrep -v '^$|^Database selected\.$|^Database closed\.$'

rm -f mytmp.$$.sql

exit
