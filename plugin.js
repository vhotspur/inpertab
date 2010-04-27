function Plugin(id, name) {
	this.id = id;
	this.name = name;
	this.getElementBySymbol = function(smb) {
		for (var i=0; i<ELEMENTS.length; i++) {
			if (ELEMENTS[i][0] == smb) {
				return ELEMENTS[i];
			}
		}
		return 0;
	};
	this.getName = function() {
		return this.name;
	}
	this.getId = function() {
		return this.id;
	}
	this.onResume = function() {
		
	};
	this.onSuspend = function() {
		
	};
}


