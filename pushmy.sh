#!/bin/sh
export SBT_RELEASE="2017_Q1_3"
export SBT_VER="r.chernyshev_170126_153121"
#export SBT_RELEASE="$1"
#export SBT_VER="$2"



if [ -e ".git/sbt.lock" ] 
then
	echo 'Опатулечки! Уже блокировано!'
	echo 'Информация о блокировке:'
	cat ".git/sbt.lock"
	exit -999
fi

touch ".git/sbt.lock"
echo $SBT_RELEASE > ".git/sbt.lock"
echo $SBT_VER     >> ".git/sbt.lock"

coreeditor=$(git config core.editor)

git config core.editor \"$(dirname $0)\/commit.sh\"

#Git sir!
files=$(git status -s | grep "${SBT_RELEASE}" | grep -E "^[ ?]" | sed 's/^...//')
if  test -n "$files" 
then
echo test good
	git add $(grep "<sbt.svc.version type=\"string\">${SBT_VER}</sbt.svc.version>" -rl ${files} )
	#git status --porcelain -uno | grep -v '^[[:blank:]]' > .git/current_commit.tmp
	#git commit -F .git/current_commit.tmp
	git commit
	git push origin master
fi
#grep "<sbt.svc.version type=\"string\">${SBT_VER}</sbt.svc.version>" -rl ${files}
#git add $(grep "<sbt.svc.version type=\"string\">${SBT_VER}</sbt.svc.version>" -rl $(git status -s | grep "${SBT_RELEASE}" | grep -E "^[ ?]" | sed 's/^...//') )
#git status --porcelain -uno | grep -v '^[[:blank:]]' > .git/current_commit.tmp
#git commit -F .git/current_commit.tmp
#git push origin master
git config core.editor "$coreeditor"
rm ".git/sbt.lock"
exit 0