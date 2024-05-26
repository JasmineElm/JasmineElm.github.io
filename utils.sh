#!/usr/bin/env bash

###  DEBUG          ###########################################################
#set -u -e -o errtrace -o pipefail
#trap "echo ""errexit: line $LINENO. Exit code: $?"" >&2" ERR
#IFS=$'\n\t'

###  DESCRIPTION    ###########################################################
# Helper functions to get Github pages up and running

###  FUNCTIONS      ###########################################################

_jekyll_serve() {
  xdg-open http://127.0.0.1:4000/ &
  bundle exec jekyll serve --livereload
}

_jekyll_config() {
  # install prerequisites
  sudo apt install ruby tmux
  gem install bundler
  rm Gemfile.lock
  bundle install
}

_serve_and_create() {
    post_title=$*;
    tmux new-session -d;
    tmux split-window -v;
    tmux resize-pane -D 10;
    tmux send -t 0:0.1 "_jekyll_serve" Enter;
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
              _jekyll_config
            ;;
            p)
              shift
              export -f _jekyll_serve
              export -f _create_post
              _TITLE="$*"
              _serve_and_create "$_TITLE"
              unset -f _jekyll_serve
              unset -f _create_post
            ;;
            s)
              _jekyll_serve
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
