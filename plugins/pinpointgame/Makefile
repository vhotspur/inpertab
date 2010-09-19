PO_FILES = cz.po

all: $(PO_FILES)

plugin.pot: pinpointgame.xml
	sxmloc-xml2pot <$< >$@

%.po: plugin.pot
	msgmerge --update $@ $<
