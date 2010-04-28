function PeriodicTable() {
	this.elements = new Array();
	
	this.addElement = function(element) {
		this.elements[this.elements.length] = element;
	}
	
	this._elementBackground = function(symbol, color) {
		$("#elem_" + symbol).css("background-color", color);
	}
	
	this.clearHighlighting = function() {
		for (var i=0; i<this.elements.length; i++) {
			this._elementBackground(this.elements[i].symbol, "white");
		}
	};
	
	this._highlightElementBySymbol = function(symbol) {
		this._elementBackground(symbol, "#feeebd");
	};
	
	this.highlightElementByIndex = function(idx) {
		this._highlightElementBySymbol(this.elements[idx].symbol);
	};
	
	this.highlightElement = function(elementOrSymbol) {
		if (typeof elementOrSymbol == "string") {
			this._highlightElementBySymbol(elementOrSymbol);
		} else {
			this._highlightElementBySymbol(elementOrSymbol.symbol);
		}
	};
	
	this.forEachElement = function(param, callback) {
		for (var i=0; i<this.elements.length; i++) {
			callback(param, this.elements[i]);
		}
	};
	
	this.getElementInfo = function(symbol) {
		for (var i=0; i<this.elements.length; i++) {
			if (this.elements[i].symbol == symbol) {
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
		this._elementDetails("symbol", info.symbol);
		this._elementDetails("name", info.localName);
		this._elementDetails("atomic-number", info.atomicNumber);
		this._elementDetails("mass", info.mass);
		this._elementDetails("universal-name", "&lt;unknown&gt;");
		this._elementDetails("english-name", info.englishName);
		this._elementDetails("period", info.period);
		this._elementDetails("group", info.group);
		this._elementDetails("boiling-point-kelvin", info.boilingPoint);
		this._elementDetails("melting-point-kelvin", info.meltingPoint);
		// so far, let it like this - need to check that the 
		// boiling/melting points are really set
		this._elementDetails("boiling-point-celsius", info.boilingPoint - 273);
		this._elementDetails("melting-point-celsius", info.meltingPoint - 273);
		$("#dialog-element-details").dialog({
			modal: true,
			buttons: { "Close": function() { $(this).dialog("close"); } },
			width: 500,
			title: info[1]
		});
	};
}
