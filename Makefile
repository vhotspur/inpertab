LANG = en
# LANG = cz

XSLT = xsltproc
RM = rm -f

all: table.html data.js

table.html: makehtml.xsl layout.xml l10n.dtd
	$(XSLT) makehtml.xsl layout.xml >$@

data/data.xml: data/gathered.xml data/unify-data.xsl
	$(XSLT) data/unify-data.xsl data/gathered.xml >$@

data.js: data/data2js.xsl data/data.xml 
	$(XSLT) data/data2js.xsl data/data.xml >$@

l10n.dtd: l10n/pte-$(LANG).dtd
	(echo '<!ENTITY % selected_l10n SYSTEM "$<">';echo '%selected_l10n;') >$@

l10n/pte-$(LANG).dtd: l10n/pte-$(LANG).txt
	sed 's#\([^\t ]*\)\(.*\)#<!ENTITY tr_\1 \2>#' $< >$@

clean:
	$(RM) data/data.xml data.js table.html
	$(RM) l10n.dtd l10n/pte-*.dtd
