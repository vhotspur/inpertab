function Plugin_home() {
	this.inheritFrom = Plugin;
	this.inheritFrom("home", "Home");

	this.init = function() {
	};

	this.onResume = function() {
		this.pte.clearHighlighting();
		this.pte.colorByMainFamily();
		this.pte.eachElementSetAboveText("localName");
		//this.pte.eachElementSetBelowText("electronegativity");
		this.pte.forEachElement(this.pte, function(pte, element) {
			pte.elementSetBelowHtml(element, "&nbsp;");
		});
		this.pte.forEachElement(this.pte, function(pte, element) {
			var nucleon = Math.round(element.mass);
			if (nucleon == 0) {
				nucleon = "&nbsp;&nbsp;&nbsp;&nbsp;";
			}
			var proton = element.atomicNumber;
			var disp = "<span class=\"element-core-numbers\">";
			disp += "<span>";
			disp += "<sup>" + nucleon + "</sup>";
			disp += "<sub>" + proton + "</sub>";
			disp += "</span>";
			disp += "</span>";
			pte.elementSetLeftHtml(element, disp);
		});
		
	};

	this.onSuspend = function() {
		this.pte.eachElementClearExtraText();
	};
}
