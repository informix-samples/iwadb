#!/bin/sh

#  /**************************************************************************/
#  /*                                                                        */
#  /*  Licensed Materials - Property of IBM and/or HCL                       */
#  /*                                                                        */
#  /*  "Restricted Materials of IBM"                                         */
#  /*                                                                        */
#  /*  IBM Informix Dynamic Server                                           */
#  /*  (c) Copyright IBM Corporation 2011 All rights reserved.               */
#  /*  (c) Copyright HCL Technologies Ltd. 2017.  All Rights Reserved.       */
#  /*                                                                        */
#  /**************************************************************************/
#
#  Name        : iwadb_create.sh
#  Created     : September 2017
#  Description : Utility to create the IWA Example Database in the
#                Informix database server instance.
#
#  Usage       : iwadb_create.sh [ database [ dbspace [ -v [ logfile ]]]]
#                    database : database name, default: iwadb
#                    dbspace :  DBSpace name, default: rootdbs
#                    -v :       verbose, default: silent operation
#                    logfile:   file path for verbose output logging
#
#  Note        : To get primary and foreign key constraints created
#                set below parameter CREATE_PRIMARY_FOREIGN_KEYS to ON.
#                By default, only the needed unique constraints will
#                be created.
#        
#                By default the database is created without logging.
#                To create the database with logging, set environment
#                variable WITH_LOG accordingly before running this 
#                script. Example:
#                  export WITH_LOG='with log'
#

CREATE_PRIMARY_FOREIGN_KEYS=ON  # Set to ON to enable

DB_NAME=iwadb
DB_SPACE=rootdbs
OUT=" >> /dev/null 2>&1"
VB=''
MYDATE="date +%Y-%m-%d.%T"

if [ "x$1" != "x" ]; then
  if [ "x$1" = "x-h" -o "x$1" = "x-?" ]; then
    echo "Usage: $0 [ database [ dbspace [ -v [ logfile ]]]]"
    echo "  database : database name, default: iwadb"
    echo "  dbspace :  DBSpace name, default: rootdbs"
    echo "  -v :       verbose, default: silent operation"
    echo "  logfile:   file path for verbose output logging"
    exit 1
  else
    DB_NAME=$1
  fi
fi
if [ "x$2" != "x" ]; then
  DB_SPACE=$2
fi
if [ "x$3" = "x-v" ]; then
  OUT=''
fi
if [ "x$4" != "x" ]; then
  VB=-e
  OUT=" >> $4 2>&1"
fi

eval echo "`${MYDATE}` $0: Start" ${OUT}

starttime=`date +%s`

echo "DROP DATABASE IF EXISTS ${DB_NAME};" | eval dbaccess ${VB} - - 2> /dev/null

echo "CREATE DATABASE ${DB_NAME} IN ${DB_SPACE} ${WITH_LOG};" | \
  eval dbaccess ${VB} - - ${OUT}

eval dbaccess ${VB} ${DB_NAME} iwadb_schema1.sql ${OUT}

DBDATE=MDY4/
DBMONEY=.
export DBDATE DBMONEY
eval dbaccess ${VB} ${DB_NAME} iwadb_load.sql ${OUT}
unset DBDATE DBMONEY

if [ "x${CREATE_PRIMARY_FOREIGN_KEYS}" = "xON" ]; then
  # create fancy primary and foreign key constraints
  eval dbaccess ${VB} ${DB_NAME} iwadb_schema3.sql ${OUT}
else
  # only create necessary unique constraints
  eval dbaccess ${VB} ${DB_NAME} iwadb_schema2.sql ${OUT}
  eval echo "Not creating primary and foreign key constraints." ${OUT}
  eval echo " " ${OUT}
fi

echo "UPDATE STATISTICS LOW;" | eval dbaccess ${VB} ${DB_NAME} - ${OUT}

endtime=`date +%s`
runtime=`expr ${endtime} - ${starttime}`
eval echo "`${MYDATE}` $0: End [runtime: ${runtime} seconds]" ${OUT}

exit
