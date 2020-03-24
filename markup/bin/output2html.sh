#!/bin/bash

ANSI_2_HTML=ansi2html.sh
if [ $# -lt 1 ]; then
	echo "No command given, aborting"
	exit 1
fi

command -v $ANSI_2_HTML > /dev/null 2>&1 || { echo >&2 "I require $ANSI_2_HTML but it's not installed.  Aborting."; exit 1; }

TARGET="$1.html"
echo '<pre class="f9 b9">' > $TARGET
$@ | $ANSI_2_HTML --bg=light --palette=solarized --body-only >> $TARGET
echo "</pre>" >> $TARGET
