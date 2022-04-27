#!/usr/bin/env bash

###  DEBUG          ###########################################################
#set -u -e -o errtrace -o pipefail
#trap "echo ""errexit: line $LINENO. Exit code: $?"" >&2" ERR
#IFS=$'\n\t'

###  DESCRIPTION    ###########################################################
# Helper functions to get Github pages up and running

###  VARIABLES      ###########################################################

_FULL_PATH="$(realpath "${0}")"
_PATH=${_FULL_PATH%/*}
_FULL_FN=${_FULL_PATH##*/}
_EXT=${_FULL_FN##*.}
_FN=${_FULL_FN%.*}
_logfile=$_PATH/$_FN.log

DTE="$(date +%Y-%m-%d)";
TME="$(date +%T)";
###  FUNCTIONS      ###########################################################

_write_log() {
  # run a command $@, write it to a log matching the name of thsi script.
  $@ >> $_logfile
}

_jekyll_serve() {
  xdg-open http://127.0.0.1:4000/ &
  bundle exec jekyll serve --livereload
}

_jekyll_config() {
  # install prerequisites
  sudo apt install ruby tmux
  gem install bundler
  # if following fails/grumbles, remove Gemfile.lock
  bundle install
}

_create_post ()
{ 
    local title="$1";
    safe_title=$(echo "$title" | sed 's/ /_/g' | tr '[:upper:]' '[:lower:]');
    printf "%s---
layout:     post
title:      $title
date:       $DTE $TME
categories: writing
synopsis:   change me
---" > "_posts/$DTE-$safe_title.md"
    vi "_posts/$DTE-$safe_title.md"
}


_print_help() {
  cat <<HEREDOC

Helper functions to build, serve, edit github pages

Usage:
  ${_FULL_FN} [<arguments>]
  ${_FULL_FN} -h | --help

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
              _TITLE="$*"
              #_jekyll_serve &
              _create_post "$_TITLE"
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
