#!/bin/bash
#== ======== ======== ======== ======== ======== ======== ======== ======== ==
#
#         FILE: skeleton.sh
#
#        USAGE: skeleton.sh [new filenames]
#
#  DESCRIPTION: Creates new script files with default comments 
#               from skeleton.txt
#
# REQUIREMENTS: skeleton.txt
#         BUGS: ---
#        NOTES: ---
#       AUTHOR: Phil Simpson, pgsimpso@gmail.com
#      VERSION: .01
#      CREATED: 2011-11-04 22:13 UTC
#     REVISION: 2011-11-04 22:13 UTC
#== ======== ======== ======== ======== ======== ======== ======== ======== ==

#-----------------------------------------------------------------------------
# Config options.
#-----------------------------------------------------------------------------

skeletontxt="skeleton.txt" # Name of the skeleton file you want to use.
newfilelist=$*             # Space delimited list of files to create.

#== FUNCTION ======== ======== ======== ======== ======== ======== ======== ==
#        NAME: getskeletonvars
# DESCRIPTION: Searches skeleton file for <#*#> style variables.
#              Sets skeletonvars with a newline delimited list of variables.
# PARAMETER 1: [filename] - Skeleton file you want to get variables from.
#== ======== ======== ======== ======== ======== ======== ======== ======== ==
getskeletonvars ()
{
    filename=$1
    match=`grep -o -e '<#.*#>' $filename`      # Matched bits of the file.
    match=`echo $match | sed -e 's/\s\+/\n/g'` # Put matches on newlines.
    match=`echo $match | sort | uniq`          # Remove duplicates.
    skeletonvars=$match                        # Set skeletonvars.
}

#== FUNCTION ======== ======== ======== ======== ======== ======== ======== ==
#        NAME: filltemplate
# DESCRIPTION: ---
# PARAMETER 1: ---
#== ======== ======== ======== ======== ======== ======== ======== ======== ==
filltemplate ()
{
    echo "Unimplemented"
}


#-----------------------------------------------------------------------------
# Main program.
#-----------------------------------------------------------------------------

for $newfile in $newfilelist
do
    cp $skeletontxt $newfile
    
done

