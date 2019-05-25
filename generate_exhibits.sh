#!/bin/bash

######################################################################################################
##
## Install script somewhere in the path, I copied it to my .dotfiles and symlinked in /usr/local/bin
## By naming files in a folder Ex_001 through Ex_100 as the prefix to any PDF file. Then this script will
## enumerate through the fiies, apply the exhibit coversheet with the matching number, backup the original,
## ensure letter format, and extract metadata the hard way - generating PNGs and recreating the PDFs.
## This tool has various tools to use for minimum installation, however the following configuration has
## been found to be the most robust.
##
## Each run of the script sets up a timestamped session folder with the output, original, 
## Author Mark Phillips
##
######################################################################################################

######################################################################################################
# Verify the following:
# Most systems after Lion should have this Preview script
# MacOS built-in Preview Python Script
# MAC_OSX="/System/Library/Automator/Combine PDF Pages.action/Contents/Resources/join.py"
#
# brew install gs pdf-redact-tools exiftool
#
# Prototype command for ghostscript
# gs -q -dNOPAUSE -dBATCH -sDEVICE=pdfwrite -sOutputFile=merged.pdf source1.pdf source2.pdf source3.pdf
#
# https://github.com/metaist/pdfmerge
# pip install pdfmerge
#
######################################################################################################

# brew install gs pdf-redact-tools
# pip install pdfmerge

# Name PDF exhibits properly...matching is keyed off of this
# Ex_001
# Ex_002 ...
# preceeding files (case sensitive)

# Create session timestamp folder
TIMESTAMP=`date '+%Y%m%d%H%M_%S'`

# macOS Preview
# Some tests have this rotate PDFs for no particular reason
MAC_OSX="/System/Library/Automator/Combine PDF Pages.action/Contents/Resources/join.py"
MAC_OSX_OPT="-o"

# gs
# Debugging
GHOSTSCRIPT="gs -q -dNOPAUSE -dBATCH -sDEVICE=pdfwrite -sPAPERSIZE=letter" #-sOutputFile=merged.pdf source1.pdf source2.pdf source3.pdf

# Path to coversheets
COVERSHEET_PATH='/Users/mark.phillips/Documents/Exhibit_Coversheets'
EXIFTOOL="exiftool -overwrite_original -all="
CLEANPDF="pdf-redact-tools -sanatize"

function wipe_metadata () {
  echo "Wipe_metadata called. Generate PNG and recreate PDF. Santizing for realz."

 for wipe in $TIMESTAMP/Ex_*.pdf
 do
#  echo "Exiftool and MAT to wipe metadata"
#  exiftool doesn't really wipe the metadata, but some people like this
#  exiftool -all= "$TIMESTAMP/$new_name"
   pdf-redact-tools --sanitize "$wipe"
 done
# Cleanup artifacts left by exiftool
# rm $TIMESTAMP/*.pdf_original
}


# If Exhibit coversheets are not found, abort
if [ ! -d "$COVERSHEET_PATH" ]; then
  echo "Coversheet path invalid."
  exit
fi

# Script annoucement
echo "Coversheet merge script."
echo

# Rename .PDF to .pdf to pickup  all files
echo "Lower .PDF to catch all for operations."
for f in *.PDF
do
  [ -e "$f" ] && mv "$f" "${f%.PDF}.pdf" || echo "No upper .PDF found."; break;
#  mv "$f" "${f%.PDF}.pdf"
done

# Loop through current directory and find files
# List files to be covered/prepared
for ex in Ex_*.pdf
do
  echo $ex
done

echo "Verify all files to merge."
echo

while true; do
    read -p "Did all the Exhibits you want to coverpage get listed?" yn
    case $yn in
        [Yy]* ) break;;
        [Nn]* ) exit;;
        * ) echo "Please check your Exhibits and rerun.";;
    esac
done

echo

# Create session folder
# To keep things tidy, each run is a new timestamped session
echo "Create session folder "$TIMESTAMP"."
mkdir $TIMESTAMP
echo "Create session/originals backup folder. "
mkdir $TIMESTAMP/originals

# Save, save, and save the originals, just in case
echo "Copy prepped Exhibits into originals folder for good measure. "
echo
for ex in Ex_*.pdf
do
  cp -v "$ex" "$TIMESTAMP/originals/"
done

echo

# Indvidual files workflow
# Combine exhibit cover "Exhibit 1 through 100" and the actual exhibit
echo "Backed-upped exhibits, now merging with coversheet and copying to session folder."
i=1
for ex in Ex_*.pdf
do
  exhibit=$ex
  cover=$COVERSHEET_PATH/$(printf "EX_00%03d.pdf" "$i")
  new_name=$(printf "Ex_%003d.pdf" "$i")
  sized_name=$TIMESTAMP/$(printf "Final_Ex_%003d-sized.pdf" "$i")

#  echo "macOSX built-in Preview Python script merging"
#  "$MAC_OSX" "$MAC_OSX_OPT" "$TIMESTAMP/$new_name" "$cover" "$ex"

# Testing showed this tool worked consistently without messing with the final PDF
# the macOS Preview script would sometimes rotate the final product
   pdfmerge -o "$TIMESTAMP/$new_name" "$cover" "$ex"

#  echo "Ghostscript to merge and size"
#  echo "Conforming merged to King County size needs of 8.5 x 11."
#  "$GHOSTSCRIPT" "-sOutputFile=${new_name}" $cover $exhibit
#
# Prototype command
#   $("gs -q -dNOPAUSE -dBATCH -sDEVICE=pdfwrite -sOutputFile=${TIMESTAMP}/${new_name} ${cover} '${exhibit}'")

  let i=i+1
done

echo

while true; do
    read -p "Do you want to super-wipe metadata from final files??" yn
    case $yn in
        [Yy]* ) wipe_metadata; break;;
        [Nn]* ) break;;
        * ) echo "Final Exhibit files unwiped.";;
    esac
done

# Todo eventually
# One large file, annoying blob
# Jump into the final output folder to get the nice coversheets
cd $TIMESTAMP
pdfmerge -o "All_Exhibits.pdf" *.pdf
echo "Coversheets for individual and merged PDFs complete."
echo "Thank you."
echo

# Todo
# Split large file into 4.9 MB sizes, for King County

exit