
PLUGIN_CURRENT = -1;

function onDocumentLoaded() {	
	$("#tabs-element-details").tabs();
	
	$("#dialog-element-details").dialog("destroy");
	$("#dialog-element-details").hide();
	
	var pte = new PeriodicTable();
	InitializeChemicalElements(pte);
	
	$("TD.element").click(function() {
		pte.showElementDetails($(this).attr("id").substring(5));		
	});
		
	for (var i = 0; i < PLUGINS.length; i++) {
		PLUGINS[i].setPTE(pte);
		PLUGINS[i].init();
	}
	
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
		pte.uncolorFamilies();
		pte.clearHighlighting();
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
	$("#plugin-show-home").click();
}
