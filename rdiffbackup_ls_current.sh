#!/bin/bash
#== ======== ======== ======== ======== ======== ======== ======== ======== ==
#
#         FILE: rdiffbackup_ls_current.sh
#
#        USAGE: rdiffbackup_ls_current.sh DIRECTORY...
#
#  DESCRIPTION: Scans for rdiff-backup-data directories and then lists the
#               current mirror time for each one.
#
#      OPTIONS: ---
# REQUIREMENTS: --- 
#         BUGS: ---
#        NOTES: ---
#       AUTHOR: Phil Simpson, pgsimpso@gmail.com
#      VERSION: .01
#      CREATED: 2011-11-03 22:05 UTC
#     REVISION: 2011-11-04 23:21 UTC
#== ======== ======== ======== ======== ======== ======== ======== ======== ==

#-----------------------------------------------------------------------------
# Config options
#-----------------------------------------------------------------------------

maxdepth=4

#-----------------------------------------------------------------------------
# Main program
#-----------------------------------------------------------------------------

if [ -z "$*" ]
then
    echo "You must specify a backup directory to scan."
    echo "$0 DIRECTORY..."
fi

backupdirlist=$*  # List of backup directories to scan.

#-----------------------------------------------------------------------------
# Gather the list of rdiff-backup data directories.
#-----------------------------------------------------------------------------
for backupdir in $backupdirlist
do
    for datadir in `find $backupdir -maxdepth $maxdepth -type d -name rdiff-backup-data`
    do
        dirlist="$dirlist $datadir \n"
    done
done

dirlist=`echo -e $dirlist | sort | uniq`  # Sort and remove duplicates.

#-----------------------------------------------------------------------------
# List each directory with its current mirror.
#-----------------------------------------------------------------------------
for dir in $dirlist
do
    dir=`dirname $dir`
    echo -n "$dir - "
    rdiff-backup -l $dir | grep Current
done
