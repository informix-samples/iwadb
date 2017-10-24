# iwadb
An Example Database for the Informix Warehouse Accelerator
----------------------------------------------------------

In order to demonstrate some conecpts and best practises for the
Informix Warehouse Accelerator (IWA), "iwadb" serves as an imaginary
example database that constitutes a small snowflake schema. It is
comprised of twelve tables, with the single fact table "partlist"
at the center of the snowflake. A depiction of the schema is shown
in file iwadb01.pdf.

The database and accompanying utilities and shell scripts have been
used successfully on a Linux system running both, IWA and Informix
Server. The database was created in a dbspace of 2 KB page size.


Note:
-----
  Even though some parts of "iwadb" or its data may look like a real
  database with real data, "iwadb" and the contained data is completely
  artificial and without any connection or meaning to the real world.


Files in this project:
----------------------

iwadb_create.sh    : shell script to create and load the database.

do_accel.sh        : shell script to setup or remove an accelerator.

do_mart.sh         : shell script to manage data marts.

iwadb_load.sql,
iwadb_schema*.sql  : sql files to create and load the database

tables_data.tar.gz : compressed tar archive that contains one
                     unload data file for each table.

runsql             : utility to run example queries.

q*.sql             : example SQL queries.

iwadb01.pdf        : PDF file with graphic depiction of the "iwadb" database.

iwadb_simple.png   : simplyfied depiction of the "iwadb" database.

iwadb_mart*.xml    : example mart definition XML files.


Creating the example database "iwadb":
--------------------------------------

Extract the table data unload files from the compressed tar archive.
E.g. on Linux use a command like

gzip -cd tables_data.tar.gz | tar xvBf -

Use the script "iwadb_create.sh" to create and load the
database. The shell environment must be set the same way as when
using "dbaccess". The database needs about 23 MB free space in a
DBSpace. Use a command like

  % iwadb_create.sh <database> <dbspace> -v

to create all the tables, load the data and create unique constraints
on the key columns of the tables. Finally UPDATE STATISTICS LOW
is run.  This is sufficient for later creating data marts with 1:n
relationships.

If primary and foreign key constraints are desired, edit the
script iwadb_create.sh before running it to set the variable
CREATE_PRIMARY_FOREIGN_KEYS to the value ON.

By default the database is created without logging. To create the
database with logging, set environment variable WITH_LOG accordingly
before running this script. Example:
  export WITH_LOG='with log'

To see the usage message run "iwadb_create.sh -h".


Running queries:
----------------

To execute a query, the utility "runsql" can be used. The shell
environment must be set the same way as when using "dbaccess".
With the query contained in a file, "runsql" can be used with a
command like this:

  % cat <sql file> | runsql -v

The "runsql" utility uses the "dbaccess" utility.

To see the usage message run "runsql -h" instead.

The files "q*.sql" contain example queries that show the structure
of some typical analytical queries used in data warehousing.

In order to execute a query with acceleration, "runsql" can be used
with the optional "-a" command line parameter, like this:

  % cat <sql file> | runsql -v -a

Prerequisites for acceleration to work are:

  - Informix server instance needs to be connected to an accelerator
    in a running IWA instance. You may use the utility "do_accel.sh"
    to setup or remove an accelerator and the connection to IWA.

  - A data mart that can accelerate the query must exist in the IWA
    instance and must be in state "Active" (i.e. created and loaded
    with the mart data). The files "iwadb_mart[12].xml" in this package
    can be used to create example data marts for "iwadb".
    Use the shell script "do_mart.sh" to easily create, load, list
    or drop data marts.


Considering Performance:

  First of all this database is intended as an example database to
  illustrate the concepts of executing OLAP-style queries using the
  Informix Warehouse Accelerator. Therefore the database has been
  designed to have a snowflake schema, but at the same time is simple
  enough to be understood easily and has a small footprint for quick
  download and creation, even in a rather small test system. As such
  this database does not serve well for performance comparisons of
  normal query execution (by the Informix server) versus accelerated
  query execution (by the Informix Warehouse Accelerator). It should
  not be expected that any realistic performance difference can be
  demonstrated with this database.

--
