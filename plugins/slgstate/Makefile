PO_FILES = cz.po

all: $(PO_FILES)

plugin.pot: slgstate.xml
	sxmloc-xml2pot <$< >$@

%.po: plugin.pot
	msgmerge --update $@ $<
