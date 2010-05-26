#!/bin/sh

lang="$1";

removeXmlSignature() {
	tail -n +2 "$@";
}

echo '<?xml version="1.0"?>'
echo '<periodic-table-input>'

removeXmlSignature layout.xml


echo '<plugins>'
while read plugin_id; do
	if [ -e "plugins/${plugin_id}/${lang}.po" ]; then
		sxmloc-translate plugins/${plugin_id}/${lang}.po "plugins/${plugin_id}/${plugin_id}.xml" \
			| removeXmlSignature;
	else
		removeXmlSignature "plugins/${plugin_id}/${plugin_id}.xml"
	fi
done <used-plugins.txt
echo '</plugins>'

echo '</periodic-table-input>'
