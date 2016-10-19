#!/bin/bash

DATA=$(date +%Y%m%d)
RESEARCHWORD="rio2016"
FILESPATH="/root/scripts/twitterSearch/files"
PYTHONSCRIPT="/root/scripts/twitterSearch/twitterSearch.py"
TIMEBEGIN=$(date +%s)
for i in csv json hadoop ;  do
	EXTENSION=${i}
	if [ $EXTENSION == "hadoop" ]; then
		EXTENSION="txt"
	fi
	python $PYTHONSCRIPT -f $FILESPATH/$RESEARCHWORD.$DATA.$EXTENSION -o ${i} -s $RESEARCHWORD 2>&-
	sleep 30
done
TIMEEND=$(date +%s)
TIMETOTAL=$(($TIMEEND-TIMEBEGIN))
echo "$DATA - Tempo total: $TIMETOTAL" >> $FILESPATH/twitterSearch.log
