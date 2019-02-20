#!/bin/bash
HEADER="# EDITTING THIS FILE DIRECTLY IS NOT RECOMMENDED
# THIS FILE IS GENERATED BY BUILD/assemble.sh
"

for DIR in ./*/; do
	DIR_STRIP_LEAD=${DIR#*/}
	DIR_CLEAN=${DIR_STRIP_LEAD%/}
	OUT="../RELEASE/data/sl_ascend_${DIR_CLEAN}.txt"
	echo "$HEADER" > $OUT
	cat $DIR/header.txt >> $OUT
	for FILENAME in ${DIR}*.dat; do
		SLOT=${FILENAME::-4}
		SLOT=${SLOT##*/}
		NUM=0
		cat $FILENAME | while read LINE; do
			if [[ $LINE == \#* ]]; then
				echo "$LINE" >> $OUT
			else
				echo "$SLOT	$NUM	$LINE" >> $OUT
				let "NUM += 1"
			fi
		done
		echo "" >> $OUT
	done
done