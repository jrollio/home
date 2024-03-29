#!/usr/bin/env /bin/bash

set -a

export PATH=/bin:/usr/bin:$PATH

# Source directory
SD=$HOME/home

# Source files
SF=".alias .bashrc .env .paths"

# Table of changes
dTbl=$SD/fchgs.txt

for file in $SF; do
    if [ -f $HOME/$file ]; then
        # TODO: update gracefully
        if [ "$(diff -q $HOME/$file $SD/$file)" ]; then
            echo "Appending contents of $SD/$file to $HOME/$file"
            echo "########################################################" >> $HOME/$file
            echo "# Content appended from $SD/$file on $(date)" >> $HOME/$file
            echo "########################################################" >> $HOME/$file
            cat $SD/$file >> $HOME/$file
            echo "############### End of Append ######################" >> $HOME/$file
        fi
    else
        cp $SD/$file $HOME
    fi
done

# Working directory
WD=$HOME/.tmptmp

# Create work directory
mkdir -p $WD

# Process each record in the input table
IFS=$'\t'; while read -r recid targetFile deltaFile upperMarker lowerMarker; do
    WF=$WD/$targetFile.tmp
    TF=$HOME/$targetFile
    IF=$SD/$deltaFile

	[[ ! -r $TF ]] && continue

	# Remove escaped newlines
	sed -i ':a; N; $!ba; s/\\\n//g' $TF

    # Target file line count
    TFL=`wc -l $TF | awk -F" " '{ print $1 }'`

    # Establish line boundaries
    upperLine=$(grep -nE ${upperMarker} ${TF} | cut -d: -f1 | tail -1)
    lowerLine=$(grep -nE ${lowerMarker} ${TF} | cut -d: -f1 | head -1)

    # If match was found, then result length will be  > 0...
    if [[ ${#upperLine} -gt 0 && ${#lowerLine} -gt 0 ]]; then

        # ...so do some simple boundary checks
        if [[ $upperLine -ge 2 ]]; then
            headBoundary=$((${upperLine}-1))
        else
            headBoundary=$((${upperLine}-0))
        fi;
        #if [[ $lowerLine -gt $upperLine ]]; then
        if [[ $lowerLine -ge $upperLine ]]; then
            tailBoundary=$((${TFL}-${lowerLine}))
        else
            tailBoundary=$((${TFL}-0))
        fi;
    else
        # No match, move to the next record
        continue
    fi;
    
    # If upper and lower bounds were found, process changes
    # Build source components into new target file
	head -n$headBoundary $TF > $WF && cat $IF >> $WF && tail -n$tailBoundary $TF >> $WF

    # Replace target with updated working file
    mv $WF $TF

done < $dTbl

# Cleanup
rm -rf $SD $WD

# Manual workaround until automation works
# cd; chmod u+x home/install.sh ; home/install.sh; exec /bin/bash


