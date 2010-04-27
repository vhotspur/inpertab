function ptForEachElement(func) {
	for (var i=0; i<ELEMENTS.length; i++) {
		func(ELEMENTS[i]);
	}
}

function ptElementInfo(id) {
	for (var i=0; i<ELEMENTS.length; i++) {
		if (ELEMENTS[i][0] == id) {
			return ELEMENTS[i];
		}
	}
	return 0;
}

function ptUnhighlightAll() {
	for (var i=0; i<ELEMENTS.length; i++) {
		$("#elem_" + ELEMENTS[i][0]).css("background-color", "white");
	}
}
function ptHighlightElement(number) {
	$("#elem_" + ELEMENTS[i][0]).css("background-color", "moccasin");
}
function ptHighlightElementById(id) {
	$("#elem_" + id).css("background-color", "moccasin");
}

function _elementDetails(name, value) {
	$("#element-details-" + name).html(value);
}

function ptShowElementDetails(elementId) {
	var info = ptElementInfo(elementId);
	if (info == 0) {
		return;
	}
	_elementDetails("symbol", info[0]);
	_elementDetails("name", info[1]);
	$("#dialog-element-details").dialog({
		modal: true,
		buttons: { "Close": function() { $(this).dialog("close"); } },
		title: info[1]
	});
}

PLUGINS = new Array();
PLUGIN_CURRENT = -1;

function onDocumentLoaded() {	
	$("#tabs-element-details").tabs();
	
	$("#dialog-element-details").dialog("destroy");
	$("#dialog-element-details").hide();
	
	$("TD.element").click(function() {
		ptShowElementDetails($(this).attr("id").substring(5));		
	});
	
	PLUGINS[0] = new PluginOxidationStates();
	PLUGINS[1] = new PluginDiscovery();
	
	for (var i = 0; i < PLUGINS.length; i++) {
		$("#ctrl-show-plugins").append(
			"<button class=\"plugin-show-hide\" id=\"plugin-show-"
			+ PLUGINS[i].getId() + "\">"
			+ PLUGINS[i].getName()
			+ "</button>");
	}
	$("#ctrl-show-plugins").buttonset();
	$(".plugin-show-hide").click(function() {
		if (PLUGIN_CURRENT >= 0) {
			PLUGINS[PLUGIN_CURRENT].onSuspend();
		}
		$(".plugin-board").hide();
		ptUnhighlightAll();
		var id = $(this).attr("id");
		id = id.substring(12);
		for (i = 0; i < PLUGINS.length; i++) {
			if (PLUGINS[i].getId() == id) {
				PLUGIN_CURRENT = i;
				break;
			}
		}
		$("DIV#plugin-board-" + id).show();
		PLUGINS[PLUGIN_CURRENT].onResume();
	});
	
	$(".plugin-board").hide();
	ptUnhighlightAll();
}
