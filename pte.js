function PeriodicTable() {
	this.elements = new Array();
	
	this.addElement = function(element) {
		this.elements[this.elements.length] = element;
	}
	
	this._jq = function(symbol) {
		if (typeof symbol != "string") {
			return $("#elem_" + symbol.symbol);
		} else {
			return $("#elem_" + symbol);
		}
	};
	
	this.clearHighlighting = function() {
		$("DIV.pte-element-info").removeClass("element-highlight");
	};
	
	this._highlightElementBySymbol = function(symbol) {
		this._jq(symbol).find("DIV.pte-element-info").addClass("element-highlight");
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
	
	this.elementAddClass = function(symbol, class) {
		this._jq(symbol).addClass(class);
	};
	
	this.elementRemoveClass = function(element, class) {
		this._jq(element).removeClass(class);
	};
	
	this.showElement = function(element) {
		this._jq(element).find(".pte-element-info").css("visibility", "visible");
	}
	
	this.hideElement = function(element) {
		this._jq(element).find(".pte-element-info").css("visibility", "hidden");
	}
	
	this.hideElements = function() {
		this.forEachElement(this, function(pte, element) {
			pte.hideElement(element);
		});
	}
	
	this.showElements = function() {
		this.forEachElement(this, function(pte, element) {
			pte.showElement(element);
		});
	}
	
	this.elementSetAboveHtml = function(element, content) {
		this._jq(element).find(".pte-element-above SPAN").html(content);
	};
	this.elementSetBelowHtml = function(element, content) {
		this._jq(element).find(".pte-element-below SPAN").html(content);
	};
	this.elementSetLeftHtml = function(element, content) {
		this._jq(element).find(".pte-element-left SPAN").html(content);
	};
	
	this.eachElementSetAboveText = function(property) {
		this.forEachElement2(property, function(pte, element, property) {
			pte.elementSetAboveHtml(element, element[property]);
		});
	};
	
	this.eachElementClearExtraText = function() {
		$(".pte-element-above SPAN").html("&nbsp;");
		$(".pte-element-below SPAN").html("&nbsp;");
		$(".pte-element-left SPAN").html("");
		$(".pte-element-right SPAN").html("");
	};
	
	this.eachElementSetBelowText = function(property) {
		this.forEachElement2(property, function(pte, element, property) {
			pte.elementSetBelowHtml(element, element[property]);
		});
	};
	
	this.eachElementClearBelowText = function() {
		$(".pte-element-below SPAN").html("&nbsp;");
	};
	
	this.forEach = function(callback) {
		for (var i=0; i<this.elements.length; i++) {
			callback(this.elements[i]);
		}
	};
	
	this.forEachElement = function(param, callback) {
		for (var i=0; i<this.elements.length; i++) {
			callback(param, this.elements[i]);
		}
	};
	
	this.forEachElement2 = function(param, callback) {
		for (var i=0; i<this.elements.length; i++) {
			callback(this, this.elements[i], param);
		}
	};
	
	this.getElementInfo = function(symbol) {
		if (typeof(symbol) == 'number') {
			return this.elements[symbol];
		}
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
		this._elementDetails("universal-name", info.universalName);
		this._elementDetails("english-name", info.englishName);
		this._elementDetails("period", info.period);
		this._elementDetails("group", info.group);
		this._elementDetails("electronegativity", info.electronegativity);
		this._elementDetails("density", info.density);
		
		if (info.boilingPoint < 0) {
			this._elementDetails("boiling-point-kelvin", "?");
			this._elementDetails("boiling-point-celsius", "?");
		} else {
			this._elementDetails("boiling-point-kelvin", info.boilingPoint);
			this._elementDetails("boiling-point-celsius", info.boilingPoint - 273);
		}
		if (info.meltingPoint < 0) {
			this._elementDetails("melting-point-kelvin", "?");
			this._elementDetails("melting-point-celsius", "?");
		} else {
			this._elementDetails("melting-point-kelvin", info.meltingPoint);
			this._elementDetails("melting-point-celsius", info.meltingPoint - 273);
		}
		
		var dialogTitle = info.universalName + " (" + info.localName + ")";
		if (dialogTitle == " ()") {
			dialogTitle = info.englishName;
		}
		
		$("#dialog-element-details").dialog({
			modal: true,
			buttons: { "Close": function() { $(this).dialog("close"); } },
			width: 500,
			title:  dialogTitle
		});
	};
	
	this.colorByMainFamily = function() {
		this.forEachElement2(null, function(pte, element, xxx) {
			pte.elementAddClass(element,
				"element-family-" + element.families[0]);
		});
	};
	
	this.uncolorFamilies = function() {
		this.forEachElement2(null, function(pte, element, xxx) {
			var classes = pte._jq(element).attr("class").split(/\s+/);
			$.each(classes, function(index, item) {
				if (item.match(/^element-family-/i)) {
					pte.elementRemoveClass(element, item);
				}
			});
		});
	};
}
