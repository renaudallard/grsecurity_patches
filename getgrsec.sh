#!/bin/sh
ftp -V -o grsec.html "http://grsecurity.net/test.php"
grep grsecurity- grsec.html > grsec2.html
perl -p -i -e 's/href=/\n/g' grsec2.html 
cat grsec2.html |  awk '{print $1}' |egrep -v "\.sig|div" | sed 's/"//g' | while read URL
do
	echo ${URL}
	ftp -c -V "http://grsecurity.net/${URL}"
done

rm grsec.html grsec2.html 

git add *
git commit -a -C 6a0abdba5dd74430d661317c6cf7458a04a9348f
git push


