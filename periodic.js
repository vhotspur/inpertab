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

function onDiscoveryYearSlide(event, ui) {
	$("#p-discovery-label-year").text(ui.value);
	ptUnhighlightAll();
	ptForEachElement(function(elem) {
		if (elem[2][0] < ui.value) {
			ptHighlightElementById(elem[0]);
		}
	});
	return true;
}

function onOxidationStateHighlight(state) {
	ptUnhighlightAll();
	ptForEachElement(function(elem) {
		for (var i=0; i < elem[3].length; i++) {
			if (elem[3][i] == state) {
				ptHighlightElementById(elem[0]);
			}
		}
	});
	return true;
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

function onDocumentLoaded() {	
	$("#p-discovery-ctrl-year").slider({
		max: 2010,
		min: 1600,
		slide: onDiscoveryYearSlide,
		change: onDiscoveryYearSlide
	});
	$("#p-discovery-ctrl-year").slider("value", 2010);
	
	$("#ctrl-clear").button();
	$("#ctrl-clear").click(ptUnhighlightAll);
	
	$("#p-oxidationstates-wrap").buttonset();
	$("#p-oxidationstates-wrap input[type=checkbox]").click(function() {
		var checked = $(this).attr("checked");
		var myid = $(this).attr("id");
		var oxst = myid.substring(22);
		$("#p-oxidationstates-wrap input[type=checkbox]").attr("checked", false);
		if (checked) {
			onOxidationStateHighlight(oxst);
			$(this).attr("checked", true);
		} else {
			ptUnhighlightAll();
		}
		$("#p-oxidationstates-wrap input[type=checkbox]").button("refresh");
	});
	
	ptUnhighlightAll();
	
	$(".plugin-board").hide();
	$(".plugin-show").click(function() {
		$(".plugin-board").hide();
		ptUnhighlightAll();
		var id = $(this).attr("id");
		$("DIV#plugin-board-" + id.substring(12)).show();
	});
	
	$("#tabs-element-details").tabs();
	
	$("#dialog-element-details").dialog("destroy");
	$("#dialog-element-details").hide();
	
	$("TD.element").click(function() {
		ptShowElementDetails($(this).attr("id").substring(5));
		
	});
}
