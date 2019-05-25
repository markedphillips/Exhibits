# Mail Merge Exhibit Coversheet 1-100
#rename Ex.pdf to Ex_.pdf

# brew install poppler
# separate each page and number 1-100 with leading zeros for ls sort
#pdfseparate EX_.pdf EX_%05d.pdf

# Ghostscript
gs -q -dNOPAUSE -dBATCH -sDEVICE=pdfwrite -sOutputFile=merged.pdf source1.pdf source2.pdf source3.pdf