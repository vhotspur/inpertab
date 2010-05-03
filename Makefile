
XSLT = xsltproc
RM = rm -f

all: table.html data.js

input.xml: used-plugins.txt layout.xml
	./merge-inputs.sh >$@

table.html: makehtml.xsl input.xml
	$(XSLT) makehtml.xsl input.xml >$@

data/data.xml: data/gathered.xml data/unify-data.xsl
	$(XSLT) data/unify-data.xsl data/gathered.xml >$@

data.js: data/data2js.xsl data/data.xml 
	$(XSLT) data/data2js.xsl data/data.xml >$@

clean:
	$(RM) data/data.xml data.js table.html input.xml
