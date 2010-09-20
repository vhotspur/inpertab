PO_FILES = cs.po

all: $(PO_FILES)

plugin.pot: pinpointgame.xml
	sxmloc-xml2pot <$< >$@

%.po: plugin.pot
	msgmerge --update $@ $<
