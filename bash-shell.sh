#!/bin/bash

# -e makes the whole script exit upon failure
# -o pipeline forces a failure when there's a failure anywhere
# in the pipeline (cmd1 | cmd2 | cmd3)  
set -eo pipefail

echo "this is a shell"


