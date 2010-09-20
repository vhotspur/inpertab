TRANSLATION = cs

DATA_ORIGINAL = \
	data/cafeconleche-allelements.xml \
	data/kdeedu-elements.xml \
	data/names.xml

XSLT = xsltproc --stringparam TRANSLATION "$(TRANSLATION)"
RM = rm -f

all: table.html data.js

input.xml: used-plugins.txt layout.xml
	@if [ -z "$(TRANSLATION)" ]; then \
		echo "Error: TRANSLATION variable not set."; \
		exit 1; \
	fi
	./merge-inputs.sh "$(TRANSLATION)" >$@

data/data.xml: data/gathered.xml data/unify-data.xsl
	$(XSLT) data/unify-data.xsl data/gathered.xml >$@

data/gathered.xml: $(DATA_ORIGINAL)
	touch $@

data/names.xml: data/names.txt data/names2xml.awk
	data/names2xml.awk <data/names.txt >$@

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

# special target when no language selected
l10n/.po:

makehtml-l10n.xsl: makehtml.xsl l10n/$(TRANSLATION).po l10n/pte.pot
	if [ -f "l10n/$(TRANSLATION).po" ]; then \
		sxmloc-translate l10n/$(TRANSLATION).po makehtml.xsl >$@; \
	else \
		if [ -z "$(TRANSLATION)" ]; then \
			echo "Error: you must select localization via the TRANSLATION variable."; \
		else \
			echo "Error: localization '$(TRANSLATION)' not available."; \
		fi; \
		exit 1; \
	fi

table.html: makehtml-l10n.xsl input.xml
	$(XSLT) makehtml-l10n.xsl input.xml >$@


clean:
	$(RM) data/data.xml data.js table.html input.xml
	$(RM) makehtml-l10n.xsl l10n/pte.pot
