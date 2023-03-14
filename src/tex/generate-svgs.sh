#!/bin/bash

cd ./source

find . -type f -regex '\.\/[0-9]+\.tex' -exec pdflatex {} \; > /dev/null
find . -type f -regex '\.\/[0-9]+\.pdf' -exec pdfcrop {} \; > /dev/null

> ../../assets/svgs.json

i=1
filesCount=$(ls -d -- *[0-9]-crop.pdf | wc -l)
arrayOpen=""
arrayClose=""
fileNamePat="([0-9]+)-crop.pdf"

for pdfFile in $(ls -d -- *[0-9]-crop.pdf)
do
  if [[ $pdfFile =~ $fileNamePat ]] 
  then
    echo "PDF: $pdfFile"
    pdf2svg $pdfFile ../../../public/svg/${BASH_REMATCH[1]}.svg
    pdfWidth=`pdfinfo $pdfFile | grep "Page size" | sed -e "s/[^0-9]\+\([0-9]\+\)\sx\s\([0-9]\+\).*/\1/g"`
    pdfHeight=`pdfinfo $pdfFile | grep "Page size" | sed -e "s/[^0-9]\+\([0-9]\+\)\sx\s\([0-9]\+\).*/\2/g"`
    pdfWidth=`echo "$pdfWidth*1.333" | bc -l`
    pdfHeight=`echo "$pdfHeight*1.333" | bc -l`
    pdfWidth=${pdfWidth%.*}
    pdfHeight=${pdfHeight%.*}
    echo "Size: $pdfWidth x $pdfHeight px"
    echo "---"

    fileName=${BASH_REMATCH[1]}.svg
    if [[ $i == 1 ]]
    then
      arrayOpen="["
    else
      arrayOpen=""
    fi

    if [[ $i == $filesCount ]]
    then
      arrayClose="]"
    else
      arrayClose=","
    fi

    echo "$arrayOpen{\"$fileName\": {\"width\": $pdfWidth, \"height\": $pdfHeight}}$arrayClose" >> ../../assets/svgs.json
  fi
  i=$((i+1))
done

rm ./*.pdf > /dev/null
rm ./*.log > /dev/null
rm ./*.aux > /dev/null
