#!/usr/bin/env /bin/bash

export PATH=/bin:/usr/bin:$PATH

# Source directory
SD=$HOME/home

# Source files
SF="$SD/.alias $SD/.env $SD/.paths"
UP=$SD/ps1_userpart.txt

# Working directory
WD=$HOME/.tmptmp

# Filename
FN=".bashrc"

# Working file
WF=$WD/$FN.tmp

# File to be modified ("TF - target file")
TF=$HOME/$FN

# File to be inserted
IF=$SD/modf.txt

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

# Create work directory
mkdir -p $WD

# Build source components into new target file
head -n$TC $TF > $WF && cat $IF >> $WF && tail -n$BC $TF >> $WF

# Remove escaped newlines
sed ':a; N; $!ba; s/\\\n//g' $WF > $WF
bashrcLen=$(wc -l ${WF} | cut -d' ' -f1)
usrPartLn=$(grep -nE '^[^#]\s+local\ userpart\=' ${WF} | cut -d':' -f1)
insertBeg=$((${usrPartLn}-1))
insertEnd=$((${bashrcLen}-${usrPartLn}))
# tgtLnNm=$(grep -nE '^[^#].*local\ userpart' ${WF} | cut -d':' -f1)
# bashStart="$(grep -n '__bash_prompt() {' ${WF} | cut -d':' -f 1)"
# bashEnd="$(grep -ne '^__bash_prompt$' ${WF} | cut -d':' -f 1)"

head -n$insertBeg $WF > $TF && cat $UP >> $TF && tail -n$insertEnd $WF >> $TF

# mv $WF $TF

# Cleanup
rm -rf $SD $WD

# Manual workaround until automation works
# chmod u+x $HOME/home/install.sh
# $HOME/home/install.sh
