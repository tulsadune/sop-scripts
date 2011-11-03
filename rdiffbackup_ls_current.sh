#!/bin/bash

########
#
# rdiffbackup_ls_current.sh DIRECTORY...
#
# This script will scan for rdiff-backup-data directories and then list the
# current mirror time for each one.
########

########
# Config options
########

maxdepth=4

########
# Main program
########

if [ -z "$*" ]
then
    echo "You must specify a backup directory to scan."
    echo "$0 DIRECTORY..."
fi

########
# backup_dir_list is the space seperated list of backup directories to scan
# which is passed in from the command line.
########
backup_dir_list=$*

########
# Gather the list of rdiff-backup data directories.
########
for backup_dir in $backup_dir_list
do
    for new_rdiffdata_dir in `find $backup_dir -maxdepth $maxdepth -type d -name rdiff-backup-data`
    do
        rdiffdata_dir_list="$rdiffdata_dir_list $new_rdiffdata_dir \n"
    done
done

########
# Sort and remove duplicates.
########
rdiffdata_dir_list=`echo -e $rdiffdata_dir_list | sort | uniq`

########
# List each directory with its current mirror.
########
for dir in $rdiffdata_dir_list
do
    dir=`dirname $dir`
    echo -n "$dir - "
    rdiff-backup -l $dir | grep Current
done
