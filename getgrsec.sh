#!/bin/sh

ftp -V -o - "http://grsecurity.net/test.php" | grep grsecurity- | perl -p -e 's/href=/\n/g' | awk '/\.patch/ {print $1}' |egrep -v "\.sig|div|iptables" | sed 's/"//g' | while read URL
do
	echo ${URL}
	ftp -C -V "http://grsecurity.net/${URL}"
done

git add *
git commit -a -C 6a0abdba5dd74430d661317c6cf7458a04a9348f
git push


