#!/bin/bash
set -ue

script_dir=$(dirname $(realpath $0))
source "$script_dir/env.sh"
to_local="$script_dir/to-local-file.sh"

$P4 opened -c "$ACTIVE_CL" | sed 's/#.*//' | $to_local
