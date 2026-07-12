#!/bin/sh
set -e

mkdir -p /.input
mkdir -p /.output
echo 'Searching for PDFs in /.input...'
echo 'Files in /.input:'
ls -lh /.input/ || echo 'Directory is empty'
echo ""
count=0
for pdf in /.input/*.pdf
do
  if [ -f "$pdf" ]
  then
    filename=$(basename "$pdf")
    echo "Converting: $filename to $filename.md..."
    cat "$pdf" | markitdown > "/.output/$filename.md"
    if [ $? -eq 0 ]
    then
      echo "SUCCESS: $filename.md"
      count=$((count + 1))
    else
      echo "FAILED: $filename"
      rm -f "/.output/$filename.md"
    fi
  fi
done
echo ""
if [ "$count" -eq 0 ]
then
  echo "No PDF files found in /.input"
  echo "Please place your PDF files in the .input folder"
else
  echo "============================================================="
  echo "Conversion Summary: $count file(s) converted"
  echo "Output location: /.output/"
  echo "============================================================="
fi
