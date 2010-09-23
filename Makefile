TRANSLATION = cs

DATA_ORIGINAL = \
	data/cafeconleche-allelements.xml \
	data/kdeedu-elements.xml \
	data/families.xml \
	data/names.xml

DEPLOY_DIRNAME = pte
DEPLOY_ARCHIVE = $(DEPLOY_DIRNAME).tar.gz
DEPLOY_PACKER = tar czf

PLUGINS = used-plugins.txt

XSLT = xsltproc --stringparam TRANSLATION "$(TRANSLATION)"
RM = rm -rf

all: table.html data.js

input.xml: $(PLUGINS) layout.xml
	@if [ -z "$(TRANSLATION)" ]; then \
		echo "Error: TRANSLATION variable not set."; \
		exit 1; \
	fi
	./merge-inputs.sh "$(TRANSLATION)" <$(PLUGINS) >$@

data/data.xml: data/gathered.xml data/unify-data.xsl
	$(XSLT) data/unify-data.xsl data/gathered.xml >$@

data/gathered.xml: $(DATA_ORIGINAL)
	touch $@

data/names.xml: data/names.txt data/names2xml.awk
	data/names2xml.awk <data/names.txt >$@

data/families.xml: data/families.txt data/families2xml.awk
	data/families2xml.awk <data/families.txt >$@

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


deploy: all
	mkdir $(DEPLOY_DIRNAME)
	mkdir $(DEPLOY_DIRNAME)/js
	mkdir $(DEPLOY_DIRNAME)/css
	cp table.html $(DEPLOY_DIRNAME)/index.html
	cp table.css $(DEPLOY_DIRNAME)/
	cp data.js element.js home.js parser.js periodic.js plugin.js pte.js $(DEPLOY_DIRNAME)/
	cp js/* $(DEPLOY_DIRNAME)/js/
	cp -R css/* $(DEPLOY_DIRNAME)/css
	$(DEPLOY_PACKER) $(DEPLOY_ARCHIVE) $(DEPLOY_DIRNAME)
	$(RM) $(DEPLOY_DIRNAME)

clean:
	$(RM) data/data.xml data.js table.html input.xml
	$(RM) makehtml-l10n.xsl l10n/pte.pot
