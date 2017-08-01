#!/bin/sh
#git config core.editor \"$(dirname $0)/commit.sh\"
git status --porcelain -uno | grep -v '^[[:blank:]]' > $1
exit 0