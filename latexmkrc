# Szablon AGH (fontspec) wymaga XeLaTeX-a.
# Overleaf czyta ten plik automatycznie, więc projekt skompiluje się XeLaTeX-em
# nawet wtedy, gdy w ustawieniach wybrany jest pdfLaTeX.
$pdflatex = 'xelatex -synctex=1 -interaction=nonstopmode -file-line-error %O %S';
