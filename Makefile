
XSLT = xsltproc
RM = rm -f

all: table.html data.js

table.html: makehtml.xsl layout.xml
	$(XSLT) makehtml.xsl layout.xml >$@

data/data.xml: data/gathered.xml data/unify-data.xsl
	$(XSLT) data/unify-data.xsl data/gathered.xml >$@

data.js: data/data2js.xsl data/data.xml 
	$(XSLT) data/data2js.xsl data/data.xml >$@

clean:
	$(RM) data/data.xml data.js table.html
