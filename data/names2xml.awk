#!/bin/awk -f

BEGIN {
	FS = ":";
	print "<?xml version=\"1.0\" encoding=\"utf-8\"?>";
	print "<element-names>";
}

END {
	print "</element-names>";
}

{
	printf "\t<element symbol=\"%s\">\n", $1;
	
	printf "\t\t<name lang=\"univ\">%s</name>\n", $2;
	printf "\t\t<name lang=\"cz\">%s</name>\n", $3;
	
	printf "\t</element>\n";
}

