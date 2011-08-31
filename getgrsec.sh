#!/bin/sh
wget -q "http://grsecurity.net/test.php" -O /tmp/grsec.html
grep grsecurity- /tmp/grsec.html > /tmp/grsec2.html
perl -p -i -e 's/href=/\n/g' /tmp/grsec2.html 
cat /tmp/grsec2.html |  awk '{print $1}' |egrep -v "\.sig|div" | sed 's/"//g' | while read URL
do
	wget -q "http://grsecurity.net/${URL}"
done
git add *
git commit -a -C 6a0abdba5dd74430d661317c6cf7458a04a9348f
git push
