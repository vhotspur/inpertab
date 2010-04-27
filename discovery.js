function PluginDiscovery() {
	this.inheritFrom = Plugin;
	this.inheritFrom("discovery", "Discovery dates");
	
	this.onSlide = function(event, ui) {
		$("#p-discovery-label-year").text(ui.value);
		ptUnhighlightAll();
		ptForEachElement(function(elem) {
			if (elem[2][0] < ui.value) {
				ptHighlightElementById(elem[0]);
			}
		});
		return true;
	};
	
	this.onResume = function() {
		$("#p-discovery-ctrl-year").slider("value", $("#p-discovery-ctrl-year").slider("value"));
	};
	
	this.onSuspend = function() {
	
	};
	
	// initialize the controls
	$("#p-discovery-ctrl-year").slider({
		max: 2010,
		min: 1600,
		slide: this.onSlide,
		change: this.onSlide
	});
	$("#p-discovery-ctrl-year").slider("value", 2010);
}


