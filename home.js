function Plugin_home() {
	this.inheritFrom = Plugin;
	this.inheritFrom("home", "Home");

	this.init = function() {
	};

	this.onResume = function() {
		this.pte.clearHighlighting();
		this.pte.colorByMainFamily();
	};

	this.onSuspend = function() {
	};
}
