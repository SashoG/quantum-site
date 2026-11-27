#!/bin/sh
# Repository file policy check (ARCHITECTURE.md §10, §11.1, §13).
# Everything in this repository ends up in the web server's docroot, so CI
# fails the build on any violation and nothing reaches the server.
#
# Usage:
#   sh scripts/check-files.sh                 # check tracked source files
#   sh scripts/check-files.sh --output DIR    # check a built site (defence in depth)
set -eu

MAX_BYTES=26214400   # 25 MB
MATERIALS_RE='\.(pdf|zip|docx|pptx|xlsx|mp4|webm|jpe?g|png)$'
SERVER_SIDE_RE='(^|/)\.(htaccess|htpasswd)$|\.(php[0-9]*|phtml|phar|cgi|pl|py|rb|sh|shtml|exe|bat|cmd|ps1)$'

fail=0

# report <message> <newline-separated list>
report() {
  if [ -n "$2" ]; then
    echo "ERROR: $1" >&2
    printf '%s\n' "$2" | sed 's/^/  /' >&2
    fail=1
  fi
}

warn() {
  if [ -n "$2" ]; then
    echo "WARNING: $1" >&2
    printf '%s\n' "$2" | sed 's/^/  /' >&2
  fi
}

# ---------------------------------------------------------------------------
# Built site
# ---------------------------------------------------------------------------
if [ "${1:-}" = "--output" ]; then
  dir=${2:?usage: check-files.sh --output DIR}
  report "symlinks in build output" "$(find "$dir" -type l)"
  report "server-side or server-config files in build output" \
    "$(find "$dir" -type f | grep -iE "$SERVER_SIDE_RE" || true)"
  if [ -d "$dir/materials" ]; then
    report "disallowed file types under /materials in build output" \
      "$(find "$dir/materials" -type f | grep -viE "$MATERIALS_RE" || true)"
  fi
  report "files over 25 MB in build output" "$(find "$dir" -type f -size +25M)"
  exit $fail
fi

# ---------------------------------------------------------------------------
# Repository sources (tracked files only)
# ---------------------------------------------------------------------------
files=$(git -c core.quotepath=off ls-files)

# 1. No symlinks (mode 120000) or submodules (mode 160000)
report "symlinks and submodules are not allowed" \
  "$(git -c core.quotepath=off ls-files -s | awk '$1 == "120000" || $1 == "160000" { sub(/^[^\t]*\t/, ""); print }')"

# 2. No server-side code or server config anywhere, except maintainer scripts
report "server-side or server-config files are not allowed" \
  "$(printf '%s\n' "$files" | grep -iE "$SERVER_SIDE_RE" | grep -vE '^(scripts|server)/[^/]+\.sh$' || true)"

# 3. Lecture materials: allowlisted types only
report "disallowed file types in static/materials (allowed: pdf zip docx pptx xlsx mp4 webm jpg jpeg png)" \
  "$(printf '%s\n' "$files" | grep '^static/materials/' | grep -viE "$MATERIALS_RE" || true)"

# 4. Uploaded images: raster only (SVG can carry script)
report "disallowed file types in assets/images (allowed: jpg jpeg png webp)" \
  "$(printf '%s\n' "$files" | grep '^assets/images/' | grep -viE '\.(jpe?g|png|webp)$' || true)"

# 5. Content: Markdown only (no page-bundle html/svg/js)
report "content/ may contain only Markdown (.md)" \
  "$(printf '%s\n' "$files" | grep '^content/' | grep -viE '\.md$' || true)"

# 6. Rest of static/: no active content (html, svg, js, xml, ...)
report "disallowed file types in static/ (allowed outside materials: ico png jpg webp txt woff2)" \
  "$(printf '%s\n' "$files" | grep '^static/' | grep -v '^static/materials/' | grep -viE '\.(ico|png|jpe?g|webp|txt|woff2)$' || true)"

# 7. Size limit per file
report "files over 25 MB" \
  "$(printf '%s\n' "$files" | while IFS= read -r f; do
       [ -f "$f" ] && [ "$(wc -c < "$f")" -gt "$MAX_BYTES" ] && printf '%s\n' "$f"
     done || true)"

# 8. Naming convention for materials (warning only, does not fail the build)
warn "material file names should be lowercase Latin, digits and hyphens (e.g. matrix-optics-lecture-01.pdf)" \
  "$(printf '%s\n' "$files" | grep '^static/materials/' | grep -vE '^static/materials/[a-z0-9-]+/[a-z0-9._-]+$' || true)"

if [ "$fail" -eq 0 ]; then
  echo "check-files: OK"
fi
exit $fail
