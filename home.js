function Plugin_home() {
	this.inheritFrom = Plugin;
	this.inheritFrom("home", "Home");

	this.init = function() {
	};

	this.onResume = function() {
		this.pte.colorByMainFamily();
		
		this.pte.forEachElement(this.pte, function(pte, element) {
			var nucleon = element.mass * 1.0;
			if (nucleon <= 0.001) {
				nucleon = "&nbsp;";
			} else {
				nucleon = nucleon.toFixed(2);
			}
			var proton = element.atomicNumber;
			
			element.setExtraLeft("<span class=\"element-core-numbers\"><sup>" + proton + "</sup></span>");
			element.setExtraBelow(nucleon);
			element.setExtraAbove(element.localName);
		});
		
	};

	this.onSuspend = function() {
	};
}
