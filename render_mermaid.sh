#!/usr/bin/env bash

# formatting
_bold=$(tput bold)
_normal=$(tput sgr0)
_warn=$(tput setaf 3)
_success=$(tput setaf 2)

_backup_posts() {
  local infile="$1"
  local outfile
  outfile="$(basename $infile)"
  cp "$infile" "$outfile"
}


_preprocess_mermaid() {
  local infile="$1"
  local outfile
  outfile="${infile//.md/-mermaid.md}"
  # if we find mermaid code blocks, preprocess them
  if grep -q '```mermaid' "$infile"; then
    printf "%s$_warn* Preprocessing mermaid code blocks$_normal\\n"
    # replace mermaid code blocks with images
    npx -p @mermaid-js/mermaid-cli mmdc -i "$infile" -o "$outfile" \
      --outputFormat png \
      --backgroundColor transparent \
      --theme neutral && \
      mv "$outfile" "$infile"
    # where we see links to ./*-mermaid*.png, prepend the the .tmp/ directory
    sed -i "s#(\./#(.tmp/#g" "$infile"
  else
    printf "%s$_warn* No mermaid code blocks found$_normal\\n"
  fi
}

_backup_posts _posts/2024-05-20-mermaid_test.md
