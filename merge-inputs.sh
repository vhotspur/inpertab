#!/bin/sh

removeXmlSignature() {
	tail -n +2 "$@";
}

echo '<?xml version="1.0"?>'
echo '<periodic-table-input>'

removeXmlSignature layout.xml


echo '<plugins>'
while read plugin_file; do
	removeXmlSignature "$plugin_file"
done <used-plugins.txt
echo '</plugins>'

echo '</periodic-table-input>'
