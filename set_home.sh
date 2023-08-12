#!/bin/bash

HOMEPAGE="https://unprofession-al.github.io/homepage/home.html?data="
QUERY=`cat $HOME/.config/homepage/data.yaml | yq -j | base64 -w0`
FULL="$HOMEPAGE$QUERY"


WORKDIR=`mktemp -d -t "homepage-XXX"`
if [[ ! "$WORKDIR" || ! -d "$WORKDIR" ]]; then
  echo "Could not create temp dir"
  exit 1
fi
echo $WORKDIR

CHROMECONFIG="$HOME/.config/chromium/Default/Preferences"
if [[ -f $CHROMECONFIG ]]; then
  echo "Chromium Config.."
  cat $CHROMECONFIG  | jq '.homepage = "'$FULL'"' | jq '.homepage_is_newtabpage = false' | jq '.session.startup_urls = ["'$FULL'"]' > $WORKDIR/CHROME 
  mv $WORKDIR/CHROME $CHROMECONFIG
fi

rm -rf $WORKDIR



