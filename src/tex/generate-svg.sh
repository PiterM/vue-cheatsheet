#!/bin/bash

rm ./*.svg > /dev/null

cd ./source

find . -type f -regex '\.\/[0-9]+\.tex' -exec pdflatex {} \;
find . -type f -regex '\.\/[0-9]+\.pdf' -exec pdfcrop {} \;

fileNamePat="([0-9]+)-crop.pdf"
for pdfFile in $(ls -d -- *[0-9]-crop.pdf)
do
  if [[ $pdfFile =~ $fileNamePat ]] 
  then
    pdf2svg $pdfFile ../../../public/svg/${BASH_REMATCH[1]}.svg
  fi
done

rm ./*.pdf > /dev/null
rm ./*.log > /dev/null
rm ./*.aux > /dev/null