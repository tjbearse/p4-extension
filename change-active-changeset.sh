#!/bin/bash
set -ue

script_dir=$(dirname $(realpath $0))
source "$script_dir/env.sh"

# explanation of sed sctipts:
# 1. collapse 3 lines together (1 empty) without windows returns
# 2. kill unwanted characters
# 3. extract wanted text
ACTIVE_CL=$($P4 changes -u $P4USER -c $WORKSPACE -s pending -s shelved -L | \
	sed -n '/^Change/ { N;N; s/\r\n//g; p}' | \
	sed -e '/^$/d' -e 's// /g' -e 's/\t\{1,\}/ /g' -e 's/\(\s\)\s*/\1/g' | \
	sed "s#Change \([[:digit:]]*\) on \([[:digit:]/]*\) by \(\S*\) \*\(\w*\)\* \(.*\)#\1 \4 \5#" | \
	fzf | \
	cut -f 1 -d' ')
echo "$ACTIVE_CL" > "$ACTIVE_CL_PATH"
