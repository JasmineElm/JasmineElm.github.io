#!/usr/bin/env bash

###  DEBUG          ###########################################################
#set -u -e -o errtrace -o pipefail
#trap "echo ""errexit: line $LINENO. Exit code: $?"" >&2" ERR
#IFS=$'\n\t'

###  DESCRIPTION    ###########################################################
# Helper functions to get Github pages up and running

###  FUNCTIONS      ###########################################################

_open_browser() {
  OS="$(uname -s)"
  case "$OS" in
    Linux*)
      xdg-open http://127.0.0.1:8080/ &
      ;;
    Darwin*)
      open http://127.0.0.1:8080/
      ;;
    *)
      echo "Unknown OS: $OS"
      ;;
  esac
}

_eleventy_serve() {
  _open_browser
  npx @11ty/eleventy --serve
}

_determine_OS() {
  OS="$(uname -s)"
  case "$OS" in
    Linux*)
      _install_linux
      ;;
    Darwin*)
      _install_macos
      ;;
    *)
      echo "Unknown OS: $OS"
      ;;
  esac
}

_install_linux() {
  # install prerequisites
  sudo apt install nodejs npm tmux
  npm init -y
  npm install @11ty/eleventy --save-dev
}

_install_macos() {
  # install prerequisites
  brew install node tmux
  npm init -y
  npm install @11ty/eleventy --save-dev
}



_serve_and_create() {
    post_title=$*;
    tmux new-session -d;
    tmux split-window -v;
    tmux resize-pane -D 10;
    tmux send -t 0:0.1 "_eleventy_serve" Enter;
    tmux send -t 0:0.0 "_create_post  $(echo $post_title)" Enter;
    tmux select-pane -U;
    tmux -2 attach-session -d
}

_create_post ()
{
    DTE="$(date +%Y-%m-%d)";
    TME="$(date +%T)";
    local title="$*";
    safe_title=$(echo "$title" | sed 's/ /_/g' | tr '[:upper:]' '[:lower:]');
    printf "%s---
layout:     post
title:      $title
date:       $DTE $TME
categories: writing
synopsis:   change me
---


" > "_posts/$DTE-$safe_title.md"
    vi "+normal G$" +startinsert! "_posts/$DTE-$safe_title.md"
}


_print_help() {
  cat <<HEREDOC

Helper functions to build, serve, edit github pages

Usage:
  ${_FULL_FN} [<arguments>]

Options:
  -h    Show this screen.
  -i    Install prerequisite
  -s    start a server & open a browser
  -p    create a new post, start the server and open the browser
HEREDOC
}


###  MAIN           ###########################################################


_main() {
    if [[ -z "$*" ]]
        then _print_help;
    fi
    while getopts ":pish" opt; do
        case $opt in
            i)
              _determine_OS
              
            ;;
            p)
              shift
              export -f _eleventy_serve
              export -f _create_post
              _TITLE="$*"
              _serve_and_create "$_TITLE"
              unset -f _eleventy_serve
              unset -f _create_post
            ;;
            s)
              _eleventy_serve
            ;;
            h)
              _print_help
            ;;
            \?)
            echo "Invalid option: -$OPTARG" >&2
            ;;
        esac
    done
}

_main "$@"
