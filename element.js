/*
symbol, atomicNumber, mass,
group, period,
universalName, englishName, localName,
oxidationStates,
discoveryYear, discoveryCountries, discoveryPeople
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
	
	this.oxidationStates = arg.oxidationStates;
	this.hasOxidationState = function(state) {
		for (var i=0; i < this.oxidationStates.length; i++) {
			if (this.oxidationStates[i] == state) {
				return true;
			}
		}
		return false;
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
