#!/bin/sh
ftp -V -o grsec.html "http://grsecurity.net/test.php"
grep grsecurity- grsec.html > grsec2.html
perl -p -i -e 's/href=/\n/g' grsec2.html 
grep \.patch grsec2.html > grsec3.html
cat grsec3.html |  awk '{print $1}' |egrep -v "\.sig|div|iptables" | sed 's/"//g' | while read URL
do
	echo ${URL}
	ftp -c -V "http://grsecurity.net/${URL}"
done

rm grsec.html grsec2.html grsec3.html

git add *
git commit -a -C 6a0abdba5dd74430d661317c6cf7458a04a9348f
git push


