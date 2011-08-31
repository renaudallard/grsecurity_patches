#!/bin/sh

ftp -V -o - "http://grsecurity.net/test.php" | grep grsecurity- | perl -p -e 's/href=/\n/g' | awk '/\.patch/ {print $1}' |grep test | awk -F '\>' '{print $2}' | awk -F '\<' '{print $1}'| head -1 | while read URL
do
	echo ${URL}
	ftp -C -V "https://grsecurity.net/test/${URL}"
done

find grsecurity-* -ctime +180 -exec rm {} \;

for i in `git status | grep deleted | awk '{print $2}'`; do git update-index --assume-unchanged $i; done

git add *
git commit -a -C 6a0abdba5dd74430d661317c6cf7458a04a9348f
git push

