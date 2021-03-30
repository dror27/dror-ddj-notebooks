#!/bin/bash

F1=$1
F2=$2
FO=$3

# generate a combined file with an extra column
# column 'reduced' no longer populated on F2 so we are adding an empty value
head -1 $F2 | awk 'BEGIN {OFS=","} {print $0,"cmp"}' >$FO.csv
cat <(comm -23 <(cut -d ',' -f 1 <$F1 | sort) <(cut -d ',' -f 1 <$F2 | sort) \
	| join -t ',' -1 1 -2 1 <(sort $F1) - | awk 'BEGIN {OFS=","} {print $0,1}') \
    <(comm -13 <(cut -d ',' -f 1 <$F1 | sort) <(cut -d ',' -f 1 <$F2 | sort) \
	| join -t ',' -1 1 -2 1 <(sort $F2) - | awk 'BEGIN {OFS=","} {print $0,"",2}') \
    <(comm -12 <(cut -d ',' -f 1 <$F1 | sort) <(cut -d ',' -f 1 <$F2 | sort) \
	| join -t ',' -1 1 -2 1 <(sort $F2) - | awk 'BEGIN {OFS=","} {print $0,"",3}') \
	| grep -v "latitude,longitude" | sort -n -t ',' -k 1 >>$FO.csv