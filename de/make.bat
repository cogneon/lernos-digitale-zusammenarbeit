@echo off
echo Starting lernOS Guide Generation ...

REM Variables
set filename=lernOS-digitaleZusammenarbeit-Leitfaden-de_0.4
rem set chapters="./src/index.md ./src/lernOS_digitaleZusammenarbeit_Leitfaden_0.2.md"
rem set chapters="./src/index.md ./src/1-0-Grundlagen.md ./src/1-1-Grundidee.md ./src/1-2-Lebenszyklus.md ./src/1-3-Inhaltsverzeichnis.md ./src/1-4-Inhalt.md ./src/1-5-Produktionskette.md ./src/2-Lernpfad.md ./src/3-Anhang.md"
rem set chapters=./src/1-0-Ueber-lernOS.md ./src/1-1-Making-of.md ./src/2-0-Einfuehrung.md ./src/2-1-Warum.md ./src/2-2-Kollaborationstools.md ./src/2-3-Bereiche.md ./src/3-0-Lernreise.md ./src/4-0-Lernpfad.md ./src/4-1-Woche-0.md ./src/5-0-Kata-log.md ./src/6-0-Hintergrund-Wissen.md ./src/7-0-Vorlagen.md ./src/8-0-Abschluss.md ./src/_Anhang.md
set chapters=./src/index.md ./src/1-0-Ueber-lernOS.md ./src/1-1-Making-of.md ./src/2-0-Einfuehrung.md ./src/2-1-Warum.md ./src/2-2-Kollaborationstools.md ./src/2-3-Bereiche.md ./src/3-0-Lernreise.md ./src/4-0-Lernpfad.md ./src/4-0-Woche-0.md ./src/4-1-Woche-1.md ./src/4-2-Woche-2.md ./src/4-3-Woche-3.md ./src/4-4-Woche-4.md ./src/4-5-Woche-5.md ./src/4-6-Woche-6.md ./src/4-7-Woche-7.md ./src/4-8-Woche-8.md ./src/4-9-Woche-9.md ./src/4-10-Woche-10.md ./src/4-11-Woche-11.md ./src/4-12-Woche-12.md ./src/5-0-Kata-log.md ./src/5-0-Kata-0.md ./src/5-1-Kata-1.md ./src/5-2-Kata-2.md ./src/5-3-Kata-3.md ./src/5-4-Kata-4.md ./src/5-5-Kata-5.md ./src/5-6-Kata-6.md ./src/5-7-Kata-7.md ./src/5-8-Kata-8.md ./src/5-9-Kata-9.md ./src/5-10-Kata-10.md ./src/5-11-Kata-11.md ./src/5-12-Kata-12.md ./src/6-0-Hintergrund-Wissen.md ./src/6-1-Theorie-Kommunikation.md ./src/6-2-Theorie-Wissen-teilen.md ./src/6-3-Theorie-Zusammenarbeit.md ./src/6-4-Theorie-Retrospektive.md ./src/7-0-Vorlagen.md ./src/8-0-Abschluss.md ./src/_Anhang.md


REM Delete Old Versions
echo Deleting old versions ...
del %filename%.*

REM Create Web Version (mkdocs)
echo Creating Web Version ...
py -m mkdocs build

rem Word to MarkDown
rem "c:\Program Files\Pandoc\pandoc.exe" --from docx --to markdown "c:\Daten\GitHub\lernos-digitale-zusammenarbeit\de\lernOS_Digitale_Zusammenarbeit_Leitfaden_0.1.docx" -o "c:\Daten\GitHub\lernos-digitale-zusammenarbeit\de\src\lernOS_digitaleZusammenarbeit_Leitfaden_0.1.md" --extract-media=".\src\images"
rem pandoc --from docx --to markdown "lernOS Digitale Zusammenarbeit Leitfaden 0.3.docx" -o ".\src\lernOS_digitaleZusammenarbeit_Leitfaden_0.3.md" --extract-media=".\src\images"


REM Create Microsoft Word Version (docx)
echo Creating Word version ...
rem pandoc metadata.yaml --from markdown -s --resource-path="./src" --number-sections -V lang=de-de -o %filename%.docx %chapters%
rem pandoc metadata.yaml --from markdown --resource-path="./src" --number-sections -V lang=de-de -o TEST_OUT_lernOS-digitaleZusammenarbeit-Leitfaden-de.docx ./src/index.md ./src/lernOS_digitaleZusammenarbeit_Leitfaden_0.1.md

rem pandoc metadata.yaml --from markdown --resource-path="./src" --toc -V lang=de-de -o "TEST_OUT2_lernOS-digitaleZusammenarbeit-Leitfaden-de.docx" ./src/index.md ./src/lernOS_digitaleZusammenarbeit_Leitfaden_0.2.md --lua-filter=pagebreak.lua
rem *** pandoc metadata.yaml --from markdown --resource-path="./src" --toc -V lang=de-de --lua-filter=pagebreak.lua --file-scope --toc-depth=2 -o %filename%.docx %chapters% 
rem -F mermaid-filter nicht vorhanden

REM Create HTML Version (html)
echo Creating HTML version ...
rem pandoc metadata.yaml --from markdown -s --resource-path="./src" -F mermaid-filter --number-sections -V lang=de-de -o %filename%.html %chapters%
rem pandoc metadata.yaml --from markdown -s --resource-path="./src" --toc -V lang=de-de -o "TEST_OUT2_lernOS-digitaleZusammenarbeit-Leitfaden-de.html" ./src/index.md ./src/lernOS_digitaleZusammenarbeit_Leitfaden_0.2.md --lua-filter=pagebreak.lua
pandoc metadata.yaml --from markdown -s --resource-path="./src" --toc -V lang=de-de --lua-filter=pagebreak.lua --file-scope --toc-depth=2 -o %filename%.html %chapters% 
rem pandoc --from docx --toc -V lang=de-de --toc-depth=2 -o lernOS-Leitfaden-Digitale-Zusammenarbeit-0.3.html lernOS-Leitfaden-Digitale-Zusammenarbeit-0.3.docx --extract-media=".\src\images"

REM Create eBook Versions (epub, mobi)
echo Creating eBook versions ...
pandoc --from docx --epub-cover-image=src/images/ebook-cover.jpg --toc -V lang=de-de --toc-depth=2 -o lernOS-Leitfaden-Digitale-Zusammenarbeit-0.4.epub lernOS-Leitfaden-Digitale-Zusammenarbeit-0.4.docx
"c:\Program Files\Calibre2\ebook-convert" lernOS-Leitfaden-Digitale-Zusammenarbeit-0.4.epub lernOS-Leitfaden-Digitale-Zusammenarbeit-0.4.mobi

goto ende

REM Create PDF Version (pdf)
echo Creating PDF version ...
rem pandoc metadata.yaml --from markdown -s --resource-path="./src" -F mermaid-filter --template lernOS --number-sections --toc -V lang=de-de -o %filename%.pdf %chapters%
rem pandoc metadata.yaml --from markdown -s --resource-path="./src" --toc -V lang=de-de -o "TEST_OUT2_lernOS-digitaleZusammenarbeit-Leitfaden-de.pdf" ./src/index.md ./src/lernOS_digitaleZusammenarbeit_Leitfaden_0.2.md --lua-filter=pagebreak.lua
rem pandoc metadata.yaml --from markdown -s --resource-path="./src" --template lernOS --toc -V lang=de-de -o "TEST_OUT2_lernOS-digitaleZusammenarbeit-Leitfaden-de.pdf" ./src/index.md ./src/test.md --lua-filter=pagebreak.lua
rem pandoc metadata.yaml --from markdown -s --resource-path="./src" --pdf-engine=xelatex --template lernOS --toc -V lang=de-de -o "TEST_OUT2_lernOS-digitaleZusammenarbeit-Leitfaden-de.pdf" ./src/index.md ./src/lernOS_digitaleZusammenarbeit_Leitfaden_0.2.md --lua-filter=pagebreak.lua 
rem pandoc metadata.yaml --from markdown -s --resource-path="./src" --pdf-engine=xelatex --template lernOS --toc -V lang=de-de -o  %filename%.pdf %chapters% --lua-filter=pagebreak.lua 
rem pandoc metadata.yaml --from markdown -s --resource-path="./src" --pdf-engine=xelatex --template lernOS --toc -V lang=de-de -o "TEST_Leitfaden_0.pdf" ./src/index.md ./src/woche_0.md ./src/kata_0.md --lua-filter=pagebreak.lua 
rem pandoc metadata.yaml --from markdown -s --resource-path="./src" --template lernOS --toc -V lang=de-de -o "TEST_Leitfaden_0.pdf" ./src/index.md ./src/woche_0.md ./src/kata_0.md --lua-filter=pagebreak.lua 
pandoc metadata.yaml --from markdown -s --resource-path="./src" --pdf-engine=xelatex --template lernOS --toc -V lang=de-de -o  %filename%.pdf %chapters% --lua-filter=pagebreak.lua --file-scope -toc-depth=2
rem ACHTUNG! Unicode-Character aus md entfernen
rem [WARNING] Missing character: There is no 😉 (U+1F609) in font [SourceSansPro-Regular.otf]/OT:script=



goto ende

REM das überspringen wir erstmal!


REM Create eBook Versions (epub, mobi)
echo Creating eBook versions ...
magick -density 300 %filename%.pdf[0] src/images/ebook-cover.jpg
magick mogrify -size 2500x2500 -resize 2500x2500 src/images/ebook-cover.jpg
magick mogrify -crop 1563x2500+102+0 src/images/ebook-cover.jpg
pandoc metadata.yaml --from markdown -s --resource-path="./src" -F mermaid-filter --epub-cover-image=src/images/ebook-cover.jpg --number-sections --toc -V lang=de-de -o %filename%.epub %chapters%
pandoc metadata.yaml --from markdown -s --resource-path="./src" --epub-cover-image=src/images/ebook-cover.jpg --toc -V lang=de-de --lua-filter=pagebreak.lua --file-scope --toc-depth=2 -o %filename%.epub %chapters%
ebook-convert %filename%.epub %filename%.mobi

magick -density 300 lernOS-digitaleZusammenarbeit-Leitfaden-de_0.3.pdf[0] src/images/ebook-cover.jpg
magick mogrify -size 2500x2500 -resize 2500x2500 src/images/ebook-cover.jpg
magick mogrify -crop 1563x2500+102+0 src/images/ebook-cover.jp
pandoc metadata.yaml --from markdown -s --resource-path="./src" --pdf-engine=xelatex --epub-cover-image=src\images2\media\image1.jpeg --toc -V lang=de-de -o "TEST_OUT2_lernOS-digitaleZusammenarbeit-Leitfaden-de.epub" ./src/index.md ./src/lernOS_digitaleZusammenarbeit_Leitfaden_0.2.md --lua-filter=pagebreak.lua 
pandoc --from docx --epub-cover-image=src/images/ebook-cover.jpg --toc -V lang=de-de --toc-depth=2 -o lernOS-Leitfaden-Digitale-Zusammenarbeit-0.3.epub lernOS-Leitfaden-Digitale-Zusammenarbeit-0.3.docx
"c:\Program Files\Calibre2\ebook-convert" lernOS-Leitfaden-Digitale-Zusammenarbeit-0.3.epub lernOS-Leitfaden-Digitale-Zusammenarbeit-0.3.mobi


:ende

pause
