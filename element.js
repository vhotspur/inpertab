/*
symbol, atomicNumber, mass
group, period
universalName, englishName, localName
oxidationStates
discoveryYear, discoveryCountries, discoveryPeople
boilingPoint, meltingPoint
*/
function ChemElement(arg) {
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
}
