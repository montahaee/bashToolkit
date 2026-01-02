#!/bin/bash
set -euo pipefail

usage() {
  cat <<EOF
Usage:
  scim <output-name> <format> [-g] <resolution> [quality]

Formats:
  pdf    Scan and create a PDF (JPEG compression; requires quality)
  jpeg   Scan and create one or more JPEG images
  png    Scan and create one or more PNG images

Options:
  -g     Grayscale mode (default: Color)

Examples:
  scim scanTest pdf 300 60      # interactive multi-page -> scanTest.pdf
  scim scanTest pdf -g 300 60   # grayscale pdf
  scim scanTest jpeg 300        # interactive -> scanTest.jpeg or scanTest-001.jpeg etc.
  scim scanTest png -g 300
EOF
  exit 1
}

# Check dependencies
command -v scanimage >/dev/null 2>&1 || { echo "Error: scanimage not found"; exit 1; }
command -v convert >/dev/null 2>&1 || { echo "Error: ImageMagick 'convert' not found"; exit 1; }

# -----------------------------
# Argument parsing
# -----------------------------
OUTPUT_NAME="${1:-}"
FORMAT="${2:-}"

[[ -z "$OUTPUT_NAME" || -z "$FORMAT" ]] && usage
shift 2

MODE="Color"
if [[ "${1:-}" == "-g" ]]; then
  MODE="Gray"
  shift
fi

RESOLUTION="${1:-}"
QUALITY="${2:-}"

[[ -z "$RESOLUTION" ]] && usage

# -----------------------------
# Prepare temp dir and cleanup
# -----------------------------
TMPDIR="$(mktemp -d)"
trap 'rm -rf "$TMPDIR"' EXIT

# -----------------------------
# Common scan command (as array)
# -----------------------------
SCAN_CMD=(scanimage --mode "$MODE" --resolution "$RESOLUTION")

# -----------------------------
# Interactive multi-page scanning
# -----------------------------
page=1
echo "Starting interactive scan. To stop scanning pages type 'n' or 'no' when prompted."
while true; do
  TIFF_FILE="$TMPDIR/page$(printf "%03d" "$page").tiff"
  echo "Scanning page $page..."
  # Save each page as TIFF
  "${SCAN_CMD[@]}" --format=tiff > "$TIFF_FILE"
  echo "Saved page $page -> $TIFF_FILE"

  # Ask user whether to scan another page
  read -rp "Scan another page? [Y/n]: " ANSWER || ANSWER="n"
  case "$ANSWER" in
    ""|[Yy]* )
      page=$((page + 1))
      continue
      ;;
    * )
      break
      ;;
  esac
done

# Count pages scanned
PAGE_COUNT=$(ls -1 "$TMPDIR"/page*.tiff 2>/dev/null | wc -l)
if [[ "$PAGE_COUNT" -eq 0 ]]; then
  echo "No pages scanned. Exiting."
  exit 1
fi

# -----------------------------
# Assemble outputs
# -----------------------------
case "$FORMAT" in
  pdf)
    if [[ -z "$QUALITY" ]]; then
      echo "Error: PDF output requires JPEG quality (e.g. 60)."
      exit 1
    fi
    OUT_FILE="${OUTPUT_NAME}.pdf"
    if [[ -e "$OUT_FILE" ]]; then
      echo "Error: Output file '$OUT_FILE' already exists. Remove it or choose another name."
      exit 1
    fi

    echo "Combining $PAGE_COUNT pages into $OUT_FILE (JPEG compression quality=$QUALITY)..."
    # Use ImageMagick convert to combine TIFF pages into one PDF compressed with JPEG
    convert "$TMPDIR"/page*.tiff -compress jpeg -quality "$QUALITY" "$OUT_FILE"
    echo "Created: $OUT_FILE"
    ;;

  jpeg)
    # For JPEG/PNG, produce separate files per page if more than one
    if [[ "$PAGE_COUNT" -eq 1 ]]; then
      OUT_FILE="${OUTPUT_NAME}.jpeg"
      echo "Converting single page to $OUT_FILE..."
      convert "$TMPDIR"/page001.tiff "$OUT_FILE"
      echo "Created: $OUT_FILE"
    else
      echo "Converting $PAGE_COUNT pages to ${OUTPUT_NAME}-NNN.jpeg ..."
      i=1
      for t in "$TMPDIR"/page*.tiff; do
        idx=$(printf "%03d" "$i")
        OUT_FILE="${OUTPUT_NAME}-${idx}.jpeg"
        if [[ -e "$OUT_FILE" ]]; then
          echo "Error: Output file '$OUT_FILE' already exists. Remove or choose another name."
          exit 1
        fi
        convert "$t" "$OUT_FILE"
        echo "Created: $OUT_FILE"
        i=$((i + 1))
      done
    fi
    ;;

  png)
    if [[ "$PAGE_COUNT" -eq 1 ]]; then
      OUT_FILE="${OUTPUT_NAME}.png"
      echo "Converting single page to $OUT_FILE..."
      convert "$TMPDIR"/page001.tiff "$OUT_FILE"
      echo "Created: $OUT_FILE"
    else
      echo "Converting $PAGE_COUNT pages to ${OUTPUT_NAME}-NNN.png ..."
      i=1
      for t in "$TMPDIR"/page*.tiff; do
        idx=$(printf "%03d" "$i")
        OUT_FILE="${OUTPUT_NAME}-${idx}.png"
        if [[ -e "$OUT_FILE" ]]; then
          echo "Error: Output file '$OUT_FILE' already exists. Remove or choose another name."
          exit 1
        fi
        convert "$t" "$OUT_FILE"
        echo "Created: $OUT_FILE"
        i=$((i + 1))
      done
    fi
    ;;

  *)
    echo "Error: Unsupported format '$FORMAT'"
    usage
    ;;
esac

echo "Done."
