#!/bin/bash
set -ue

script_dir=$(dirname $(realpath $0))
source "$script_dir/env.sh"

$P4 -x - where | awk '/^\// {print $3}' | sed 's#\r##g'
