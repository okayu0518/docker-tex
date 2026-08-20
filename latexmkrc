# LaTeX compiler settings (upLaTeX: supports both Japanese and English)
$latex = 'uplatex -interaction=nonstopmode -synctex=1 %O %S';
$bibtex = 'pbibtex %O %B';
$dvipdf = 'dvipdfmx -o %D %S';
$makeindex = 'mendex %O -o %D %S';

# PDF generation method (3 = compile DVI and convert to PDF)
$pdf_mode = 3;

# BibTeX configuration
$bibtex_use = 2;  # Run BibTeX when needed

# Compilation settings
$max_repeat = 5;  # Maximum number of compilation passes
$preview_mode = 0;  # Disable preview

# Files to delete during cleanup (keep synctex.gz for editor navigation)
$clean_ext = 'nav snm log aux dvi fls fdb_latexmk bbl blg';
