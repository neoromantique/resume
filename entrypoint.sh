#!/bin/bash
set -e

# Default values
INPUT_FILE=${1:-"improved-resume.md"}
OUTPUT_PDF=${2:-"david-aizenberg-resume.pdf"}
CSS_FILE=${3:-"style.css"}
DPI=${4:-300}
ZOOM=${5:-1.0}
MARGINS=${6:-8}

echo "Generating resume PDF with the following settings:"
echo "Input file: $INPUT_FILE"
echo "CSS file: $CSS_FILE"
echo "Output PDF: $OUTPUT_PDF"
echo "DPI: $DPI"
echo "Zoom: $ZOOM"
echo "Margins: $MARGINS"

# Generate HTML from markdown
pandoc "$INPUT_FILE" -s -c "$CSS_FILE" --metadata pagetitle="David Aizenberg Resume" -o resume.html

# Generate PDF from HTML
/usr/local/bin/wkhtmltopdf \
  --enable-local-file-access \
  --page-size A4 \
  --dpi "$DPI" \
  --zoom "$ZOOM" \
  --margin-top "$MARGINS" \
  --margin-bottom "$MARGINS" \
  --margin-left "$MARGINS" \
  --margin-right "$MARGINS" \
  --print-media-type \
  --no-background \
  --disable-smart-shrinking \
  resume.html "$OUTPUT_PDF"

echo "PDF generation complete: $OUTPUT_PDF"
