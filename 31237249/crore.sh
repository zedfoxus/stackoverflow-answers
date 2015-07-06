#!/bin/bash

FILENAME=crore-original-poster.txt
sort --field-separator=',' -rn -k 2,2 \
	 -k 1,1 $FILENAME \
	 |
	 awk -F',' '
BEGIN {
	line = 1;
	maxdate = "";
	id = -1;
}
{
	if (line == 1) {
		maxdate = $1;
		id = $2;

		# to print entire line, use this
		#print $0;

		# to print only date and id, use this
		print maxdate,"\t",id;
	}
	else {
		if ($2 != id) {
			maxdate = $1;
			id = $2;
			#print $0;
			print maxdate,"\t",id;
		} 
	}
	line++;
}
'
