function PluginOxidationStates() {
	this.inheritFrom = Plugin;
	this.inheritFrom("oxidationstates", "Oxidation states");
	
	this.selectState = function(state) {
		this.pte.clearHighlighting();
		this.pte.forEachElement(this.pte, function(pte, elem) {
			for (var i=0; i < elem[3].length; i++) {
				if (elem[3][i] == state) {
					pte.highlightElement(elem[0]);
				}
			}
		});
	};
	
	this.onChange = function() {
		this.selectState($("input[name=p-oxidationstates-state]:radio:checked").val());
		return true;
	};
	
	this.onResume = function() {
		this.onChange();
	};
	this.onSuspend = function() {
	
	};

	this.init = function() {
		// initialize the controls
		$("#p-oxidationstates-radio").buttonset();
		$("#p-oxidationstates-radio input:radio").click($.proxy(this.onChange, this));
		$("#p-oxidationstates-st-1").attr("checked", "checked");
		$("#p-oxidationstates-radio").buttonset("refresh");
	};
}


