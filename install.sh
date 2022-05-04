#!/usr/bin/env /bin/bash

export PATH=/bin:/usr/bin:$PATH

# Source directory
SD=$HOME/home

# Source files
SF="$SD/.alias $SD/.env $SD/.paths"

# Working directory
WD=$HOME/.tmptmp

# File name
FN=".bashrc"

# Working file
WF=$WD/$FN.tmp

# File to be modified ("TF - target file")
TF=$HOME/$FN

# File to be inserted
IF=$WD/modf.txt

# Target file line count
TFL=`wc -l $TF | awk -F" " '{ print $1 }'`

# Top cutoff
TC=$((`grep -n "# Alias definitions."  $TF | awk -F: '{ print $1 }'`-1))

# Bottom boundary
BB=$((`grep -n "# enable programmable completion features" $TF | awk -F: '{ print $1 }'`-1))

# Bottom cutoff
BC=$(($TFL-$BB))

# Move dotfiles to home directory
for file in $SF; do cp -f $file $HOME; done

# Create temp directory
mkdir -p $WD

# Build source components into new target file
head -n$TC $TF > $WF && cat $IF >> $WF && tail -n$BC $TF >> $WF && mv $WF $TF

# Cleanup
rm -rf $SD $WD 
