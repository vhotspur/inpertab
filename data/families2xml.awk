#!/bin/awk -f

BEGIN {
	FS = ":";
	print "<?xml version=\"1.0\" encoding=\"utf-8\"?>";
	print "<element-families>";
}

END {
	print "</element-families>";
}

{
	printf "\t<element symbol=\"%s\">\n", $1;
	
	split($2, arr, ",");
	for (a in arr) {
		printf "\t\t<family>%s</family>\n", arr[a];
	}
	
	printf "\t</element>\n";
}

