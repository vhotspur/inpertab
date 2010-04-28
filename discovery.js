function PluginDiscovery() {
	this.inheritFrom = Plugin;
	this.inheritFrom("discovery", "Discovery dates");
	
	this.onSlide = function(event, ui) {
		$("#p-discovery-label-year").text(ui.value);
		this.pte.clearHighlighting();
		this.pte.forEachElement(this.pte, function(pte, elem) {
			if (elem.wasDiscoveredBefore(ui.value)) {
				pte.highlightElement(elem);
			}
		});
		return true;
	};
	
	this.onResume = function() {
		$("#p-discovery-ctrl-year").slider("value", $("#p-discovery-ctrl-year").slider("value"));
	};
	
	this.onSuspend = function() {
	
	};

	this.init = function() {
		// initialize the controls
		$("#p-discovery-ctrl-year").slider({
			max: 2010,
			min: 1600,
			slide: $.proxy(this.onSlide, this),
			change: $.proxy(this.onSlide, this)
		});
		$("#p-discovery-ctrl-year").slider("value", 2010);
	};
}


