# LaTeX compiler settings
$latex = 'uplatex -interaction=nonstopmode -synctex=1 %O %S';
$bibtex = 'pbibtex %O %B';
$dvipdf = 'dvipdfmx -f myfonts.map -o %D %S';
$makeindex = 'mendex %O -o %D %S';

# PDF generation method (3 = compile DVI and convert to PDF)
$pdf_mode = 3;

# BibTeX configuration
$bibtex_use = 2;  # Run BibTeX when needed

# Compilation settings
$max_repeat = 5;  # Maximum number of compilation passes
$preview_mode = 0;  # Disable preview

# Files to delete during cleanup
$clean_ext = 'nav snm log aux dvi fls fdb_latexmx bbl blg synctex.gz';# LaTeX processing configuration
