#!/bin/bash

F1=$1
F2=$2
FO=$3

# lines only in F1
head -1 $F1 >"${FO}_f1.csv"
comm -23 <(cut -d ',' -f 1 <$F1 | sort) <(cut -d ',' -f 1 <$F2 | sort) \
	| join -t ',' -1 1 -2 1 <(sort $F1) -  >>"${FO}_f1.csv"

# lines only in F2
head -1 $F2 >"${FO}_f2.csv"
comm -13 <(cut -d ',' -f 1 <$F1 | sort) <(cut -d ',' -f 1 <$F2 | sort) \
	| join -t ',' -1 1 -2 1 <(sort $F2) -  >>"${FO}_f2.csv"	

# lines in both in F1 and F2
head -1 $F2 >"${FO}_f3.csv"
comm -12 <(cut -d ',' -f 1 <$F1 | sort) <(cut -d ',' -f 1 <$F2 | sort) \
	| join -t ',' -1 1 -2 1 <(sort $F2) -  >>"${FO}_f3.csv"		