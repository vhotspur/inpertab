function PeriodicTable() {
	
	// FIXME - do this better
	// (hide the ELEMENTS variable completely?)
	this.elements = ELEMENTS;
	
	this._elementBackground = function(symbol, color) {
		$("#elem_" + symbol).css("background-color", color);
	}
	
	this.clearHighlighting = function() {
		for (var i=0; i<this.elements.length; i++) {
			this._elementBackground(this.elements[i][0], "white");
		}
	};
	
	this._highlightElementBySymbol = function(symbol) {
		this._elementBackground(symbol, "#feeebd");
	};
	
	this.highlightElementByIndex = function(idx) {
		this._highlightElementBySymbol(this.elements[idx][0]);
	};
	
	this.highlightElement = function(symbol) {
		this._highlightElementBySymbol(symbol);
	};
	
	this.forEachElement = function(param, callback) {
		for (var i=0; i<this.elements.length; i++) {
			callback(param, this.elements[i]);
		}
	};
	
	this.getElementInfo = function(symbol) {
		for (var i=0; i<this.elements.length; i++) {
			if (this.elements[i][0] == symbol) {
				return this.elements[i];
			}
		}
		return 0;
	};

	this._elementDetails = function(name, value) {
		$(".element-details-" + name).html(value);
	};

	this.showElementDetails = function(symbol) {
		var info = this.getElementInfo(symbol);
		if (info == 0) {
			return;
		}
		this._elementDetails("symbol", info[0]);
		this._elementDetails("name", info[1]);
		this._elementDetails("atomic-number", info[4]);
		this._elementDetails("mass", info[5]);
		$("#dialog-element-details").dialog({
			modal: true,
			buttons: { "Close": function() { $(this).dialog("close"); } },
			title: info[1]
		});
	};
}
