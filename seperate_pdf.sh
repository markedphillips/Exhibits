# Helper functions and notes

# After generating the mail merge update naming
# Mail Merge Exhibit Coversheet 1-100
#rename Ex.pdf to Ex_.pdf

# brew install poppler # for pdfseperate
# separate each page and number 1-100 with leading zeros for ls sort
#pdfseparate EX_.pdf EX_%05d.pdf

# Ghostscript
# update opt with letter format
# look into sizing MB for upload requirements
#gs -q -dNOPAUSE -dBATCH -sDEVICE=pdfwrite -sOutputFile=merged.pdf source1.pdf source2.pdf source3.pdf