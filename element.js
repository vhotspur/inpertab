/*
symbol, atomicNumber, mass
group, period
universalName, englishName, localName
oxidationStates
discoveryYear, discoveryCountries, discoveryPeople
boilingPoint, meltingPoint
*/
function ChemElement(pte, arg) {
	this.pte = pte;
	
	this.symbol = arg.symbol;
	this.atomicNumber = arg.atomicNumber;
	this.mass = arg.mass;
	
	this.group = arg.group;
	this.period = arg.period;
	
	this.universalName = arg.universalName;
	this.englishName = arg.englishName;
	this.localName = arg.localName;
	
	this.electronegativity = arg.electronegativity;
	this.density = arg.density;
	
	this.oxidationStates = arg.oxidationStates;
	this.hasOxidationState = function(state) {
		for (var i=0; i < this.oxidationStates.length; i++) {
			if (this.oxidationStates[i] == state) {
				return true;
			}
		}
		return false;
	};
	this.getOxidationStatesList = function(delimiter) {
		if (delimiter == undefined) {
			delimiter = ",";
		}
		var roman = $.map(this.oxidationStates, function(state, idx) {
			var negative = new Array("-IV", "-III", "-II", "-I");
			var positive = new Array("I", "II", "III", "IV", "V",
				"VI", "VII", "VIII");
			if (state < 0) {
				if (state >= -4) {
					return negative[-state - 1];
				}
			} else if (state > 0) {
				if (state <= 8) {
					return positive[state - 1];
				}
			}
			return null;
		});
		return roman.join(delimiter);
	};
	
	this.families = arg.families;
	
	this.boilingPoint = arg.boilingPoint;
	if (this.boilingPoint == "") {
		this.boilingPoint = -1;
	}
	this.meltingPoint = arg.meltingPoint;
	if (this.meltingPoint == "") {
		this.meltingPoint = -1;
	}
	
	/** Element state of matter at given temperature.
	 * @param temperature Temperature in Kelvin
	 * @return Element state of matter as string
	 * @retval "unknown" Invalid temperature or state not known
	 * @retval "solid" Solid state
	 * @retval "liquid" Liquid state
	 * @retval "gas" Gas state
	 */
	this.getStateOfMatter = function(temperature) {
		if (temperature < 0) {
			return "unknown";
		}
		if ((this.meltingPoint == -1) || (this.boilingPoint == -1)) {
			return "unknown";
		}
		if (temperature < this.meltingPoint) {
			return "solid";
		} else if (temperature < this.boilingPoint) {
			return "liquid";
		} else {
			return "gas";
		}
	};
	
	if (arg.discoveryYear == "" || arg.discoveryYear <= 100) {
		arg.discoveryYear = 0;
	}
	this.discoveryYear = arg.discoveryYear;
	this.discoveryCountries = arg.discoveryCountries;
	this.discoveryPeople = arg.discoveryPeople;
	this.wasDiscoveredBefore = function(year) {
		return this.discoveryYear < year ? true : false;
	};
	
	this.toString = function() {
		return "[ChemElement(" + this.symbol + ")]";
	};
	
	/* View-related functions. */
	
	
	/** Access to element cell in periodic table. */
	this.cell_ = function() {
		return $("#elem_" + symbol);
	};
	/** Access to element cell in periodic table with extra selectors. */
	this.cell2_ = function(selectors) {
		return $("#elem_" + this.symbol + " " + selectors);
	};
	
	/** Highlight the element. */
	this.highlight = function() {
		this.cell2_(".pte-element-info").addClass("element-highlight");
	};
	
	this.setExtraInfo_ = function(where, content) {
		this.cell2_(".pte-element-" + where + " SPAN").html(content);
	};
	
	/** Set text displayed above the element symbol. */
	this.setExtraAbove = function(content) {
		this.setExtraInfo_("above", content);
	};
	/** Set text displayed below the element symbol. */
	this.setExtraBelow = function(content) {
		this.setExtraInfo_("below", content);
	};
	/** Set text displayed left of the element symbol. */
	this.setExtraLeft = function(content) {
		this.setExtraInfo_("left", content);
	};
	/** Set text displayed right of the element symbol. */
	this.setExtraRight = function(content) {
		this.setExtraInfo_("right", content);
	};
	
	this.clearExtras = function() {
		this.setExtraAbove("&nbsp;");
		this.setExtraBelow("&nbsp;");
		this.setExtraLeft("");
		this.setExtraRight("");
	};
	
}
