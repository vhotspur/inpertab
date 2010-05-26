LANG = en
# LANG = cz

XSLT = xsltproc
RM = rm -f

all: table.html data.js

input.xml: used-plugins.txt layout.xml
	./merge-inputs.sh >$@

data/data.xml: data/gathered.xml data/unify-data.xsl
	$(XSLT) data/unify-data.xsl data/gathered.xml >$@

data.js: data/data2js.xsl data/data.xml 
	$(XSLT) data/data2js.xsl data/data.xml >$@

l10n/pte.pot: makehtml.xsl
	sxmloc-xml2pot <$< >$@

l10n/%.po: l10n/pte.pot
	if [ -f "$@" ]; then \
		msgmerge --update $@ $<; \
		touch $@; \
	else \
		echo "Language not available: use msginit(1) to create corresponding PO file."; \
	fi

makehtml-l10n.xsl: makehtml.xsl l10n/$(LANG).po
	if [ -f "l10n/$(LANG).po" ]; then \
		sxmloc-translate l10n/$(LANG).po makehtml.xsl >$@; \
	else \
		echo "Warning: localization '$(LANG)' not available. Using default."; \
		sxmloc-translate l10n/pte.pot makehtml.xsl >$@; \
	fi

table.html: makehtml-l10n.xsl input.xml
	$(XSLT) makehtml-l10n.xsl input.xml >$@


clean:
	$(RM) data/data.xml data.js table.html input.xml
	$(RM) makehtml-l10n.xsl l10n/pte.pot
