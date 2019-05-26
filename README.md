[![forthebadge](https://forthebadge.com/images/badges/fuck-it-ship-it.svg)](https://forthebadge.com)
# Generate Exhibit Coverpages

Are you the sad sucker who has to compile the Exhibits in pleadings prior to subnmission to the Court? Are you skilled at dragging and dropping Preview thumbnails or Acrobat PDFs from one Exhibit A-Z or Exhibits 1-100 to the associated exhibit? Does it suck to do this over and over and over and over agian, wondering if you went to law school for this or worse, you're the paralegal tasked with doing this mindless job.  Presenting generate_exhibits a Bash script and accompanying files to make this segment of your life obsolete giving you more time to do whatever. 

[![Repo on GitHub](https://img.shields.io/badge/repo-GitHub-3D76C2.svg)](https://github.com/YOU/YOUR-REPO)
[![Bash Shell](https://badges.frapsoft.com/bash/v1/bash.png?v=103)](https://github.com/ellerbrock/open-source-badges/)


**Install**

```
brew install pdf-redact-tools
pip install pdfmerge
git clone https://github.com/markedphillips/generate_exhibits
```

**Location of Exhibit coversheets**

```
cd generate_exhibits
mkdir -p ~/Documents/Exhibit_Coversheets
cp -v ./coverpages/*.pdf ~/Documents/Exhibit_Coversheets
pico ./generate_exhibits.sh
# Ctrl-W, COVERSHEET_PATH
# Change COVERSHEET_PATH='/Users/[YOURNAMEHERE]/Documents/Exhibit_Coversheets'
# Ctrl-O, or Ctrl-X, Yes
ln -s ./generate_exhibits.sh /usr/local/bin/generate_exhibits
# You are welcome
```
**What happens now**

Go to your favorite annoying pile of exhibits and add the following to the filename.

```
"Ex_001 Super Important Evidence Exhibit 1.pdf"
"Ex_002 Unimpeachable Certified Document 2.PDF"
# and so on...just add Ex_001...Ex_100 
./generate_exhibits
```

**generate_exhibits**

When the script runs, it creates a timestamped session folder which it copies the files into. Just in case you wanted another copy of your fucking exhibits. Then it lowers the extension for annoying programs or people that forgot caps lock when typing PDF. Verifies with you that it scanned and found all the relevant exhibits you want. 

Then merges the coverpage with the exhibit copies them into the timestamp folder and if you uncomment the code for sanatizing, it will also generate PNGs of the PDFs and re-PDF them as to wipe all metadata from them. 

The script will also merge all of the exhibits into an additional file All_Exhibits.pdf because why not have another copy. 

**Optional**  

Initially, was using macOS built-in Preview join.py but it acted weird with some test files. Then I thought about using Ghostscript with some sizing features, but it was getting late.  And of course, if you want to wipe metadata, using Exiftool isn't the way to go, but people do think so. 

```
brew install gs exiftool
```

By reviewing the script you will see you can change the pdf merge application to whatever you want.

seperate_pdf.sh has a few functions if you want to use the mail merge .docx and .xlsx files to create different naming conventions for your exhibits. Once you generate the mail merge exhibit you can split it up with pdfseperate.

```
pdfseparate EX_.pdf EX_%05d.pdf
```

[![forthebadge](https://forthebadge.com/images/badges/built-with-resentment.svg)](https://forthebadge.com)
[![forthebadge](https://forthebadge.com/images/badges/made-with-crayons.svg)](https://forthebadge.com)

**The "If I Don't Like You License"**

Waiver. By cloning this repo you agree to forever release any and all known and unknown claims against me, my heirs, and any of my affiliates.  Breach of this agreement, even the threat of a claim or any action by you, percieved by me to assert claims, will cause uncalculatable harm.  However, for the purpose of quantifying damages in state, federal, international, and galaxian law, you agree to liquidated damages of a googleplex.  

Parties.  If you are an attorney adverse to my interests or the interests of any entity to which I have an interest, then you personally and your associates, firm, or company can absolutely go fuck yourself. Which means you are not authorized to use in any way shape or form anything here, including source code, ideas, the Word .docx and .xlsx file, and especially the coverpage templates.  Obviously, this applies to any of the other repos which may or may not have a "I don't like you license" prominent in the README.MD. 

If you volunteer your time to helping those without legal funds, defend or protect the rights of anyone without means, you may submit issues or communicate with me regarding any bugs or features. Whether or not any updates to this repo occur is another matter.  Any suggestions, ideas, or feedback,  you provide to me, you agree to the terms of this License. Otherwise, don't expect there to be massive updates here, nor should there be a need, this is probably the most simple plebeian task of automation for splitting, merging, and preparing PDFs. 

Linux.  While it should work in Ubuntu, I have not tested it. But I will be updating this repo when I get it working on a Synology NAS and Cloudshell2 with additional support with entr.

[![forthebadge](https://forthebadge.com/images/badges/does-not-contain-treenuts.svg)](https://forthebadge.com)

**TODO**
The exhibit coverpages assume you are building from exhibit 1 onward, which means if you just run this script with Ex_005 it will fuck up. And I don't care. 
