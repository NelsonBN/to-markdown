#!/bin/bash
# Converts every .epub in INPUT_DIR to Markdown and extracts embedded images.
set -euo pipefail

INPUT_DIR="${INPUT_DIR:-/.input}"
OUTPUT_DIR="${OUTPUT_DIR:-/.output}"

mkdir -p "$OUTPUT_DIR"

echo "Searching for EPUBs in $INPUT_DIR..."
echo "Files in $INPUT_DIR:"
ls -lh "$INPUT_DIR/" || echo "Directory is empty"
echo ""

shopt -s nullglob
epubs=("$INPUT_DIR"/*.epub)

if [ ${#epubs[@]} -eq 0 ]; then
  echo "No EPUB files found in $INPUT_DIR"
  echo "Please place your EPUB files in the .input folder"
  exit 0
fi

count=0
for epub in "${epubs[@]}"; do
  filename=$(basename "$epub" .epub)
  book_out="$OUTPUT_DIR/$filename"
  mkdir -p "$book_out"

  echo "Converting: $filename.epub to $book_out/$filename.md..."

  pandoc "$epub" \
    -f epub \
    -t gfm \
    --extract-media="$book_out" \
    --wrap=none \
    -o "$book_out/$filename.md"

  echo "SUCCESS: $filename.md (images -> $book_out/media/)"
  count=$((count + 1))
done

echo ""
echo "============================================================="
echo "Conversion Summary: $count file(s) converted"
echo "Output location: $OUTPUT_DIR/"
echo "============================================================="
