#!/bin/bash

function mreadlink() {
    python -c 'import os, sys; print os.path.realpath(sys.argv[1])' $1
}

function find_apropriate_file() {
    local files=( $1 )
    echo $(basename "${files[0]}")
}

readonly SCRIPT=$(dirname $(mreadlink "$0"))
export ROOT=${ROOT:-$(mreadlink "$SCRIPT/../../")/}

readonly EMACSVER=$(find_apropriate_file "$ROOT/emacs/share/emacs/*.*")
readonly EMACSLIBEXEC=$(find_apropriate_file "$ROOT/emacs/lin/libexec/emacs/$EMACSVER/*")

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$ROOT/emacs/mac/lib/
export EMACSDATA=$ROOT/emacs/share/emacs/$EMACSVER/etc/
export EMACSDOC=$ROOT/emacs/share/emacs/$EMACSVER/etc/
export EMACSLOADPATH=$ROOT/emacs/share/emacs/$EMACSVER/site-lisp:\
$ROOT/emacs/share/emacs/site-lisp:\
$ROOT/emacs/share/emacs/$EMACSVER/site-lisp:\
$ROOT/emacs/share/emacs/$EMACSVER/lisp:\
$ROOT/emacs/share/emacs/$EMACSVER/lisp/calc:\
$ROOT/emacs/share/emacs/$EMACSVER/lisp/calendar:\
$ROOT/emacs/share/emacs/$EMACSVER/lisp/cedet:\
$ROOT/emacs/share/emacs/$EMACSVER/lisp/emacs-lisp:\
$ROOT/emacs/share/emacs/$EMACSVER/lisp/emulation:\
$ROOT/emacs/share/emacs/$EMACSVER/lisp/erc:\
$ROOT/emacs/share/emacs/$EMACSVER/lisp/eshell:\
$ROOT/emacs/share/emacs/$EMACSVER/lisp/gnus:\
$ROOT/emacs/share/emacs/$EMACSVER/lisp/international:\
$ROOT/emacs/share/emacs/$EMACSVER/lisp/language:\
$ROOT/emacs/share/emacs/$EMACSVER/lisp/mail:\
$ROOT/emacs/share/emacs/$EMACSVER/lisp/mh-e:\
$ROOT/emacs/share/emacs/$EMACSVER/lisp/net:\
$ROOT/emacs/share/emacs/$EMACSVER/lisp/nxml:\
$ROOT/emacs/share/emacs/$EMACSVER/lisp/obsolete:\
$ROOT/emacs/share/emacs/$EMACSVER/lisp/org:\
$ROOT/emacs/share/emacs/$EMACSVER/lisp/play:\
$ROOT/emacs/share/emacs/$EMACSVER/lisp/progmodes:\
$ROOT/emacs/share/emacs/$EMACSVER/lisp/term:\
$ROOT/emacs/share/emacs/$EMACSVER/lisp/textmodes:\
$ROOT/emacs/share/emacs/$EMACSVER/lisp/url:\
$ROOT/emacs/share/emacs/$EMACSVER/lisp/vc

export PATH=$ROOT/mac/libexec/emacs/$EMACSVER/$EMACSLIBEXEC:$PATH
export DYLD_LIBRARY_PATH=$ROOT/usr/lib/:$DYLD_LIBRARY_PATH

"$SCRIPT/bin/emacs" --name Portacle -T Portacle -q -l "$ROOT/config/emacs-init.el" "$@"
