#!/bin/bash
set -ue

script_dir=$(dirname $(realpath $0))
source "$script_dir/env.sh"
open_files="$script_dir/list-open-files.sh"

# before running this copy colordiffrc-gitdiff to /etc/colordiffrc or ~/.colordiffrc
# can do this automatically with use-git-diff.sh

#TODO this diffs files that aren't changed. Might want to avoid that somehow
# maybe use a for loop and drop output with less than X lines
if [ -t 1 ] ; then
	$open_files | sed -e 's#\\#\\\\#g' | xargs -I {} -n 1 $P4 diff -du3 '{}'@=$ACTIVE_CL | colordiff | less -r
else
	$open_files | sed -e 's#\\#\\\\#g' | xargs -I {} -n 1 $P4 diff -du3 '{}'@=$ACTIVE_CL
fi
