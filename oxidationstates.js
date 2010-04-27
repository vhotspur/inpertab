function PluginOxidationStates() {
	this.inheritFrom = Plugin;
	this.inheritFrom("oxidationstates", "Oxidation states");
	
	this.selectState = function(state) {
		ptUnhighlightAll();
		ptForEachElement(function(elem) {
			for (var i=0; i < elem[3].length; i++) {
				if (elem[3][i] == state) {
					ptHighlightElementById(elem[0]);
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
	
	// initialize the controls
	$("#p-oxidationstates-radio").buttonset();
	$("#p-oxidationstates-radio input:radio").click($.proxy(this.onChange, this));
	$("#p-oxidationstates-st-1").attr("checked", "checked");
	$("#p-oxidationstates-radio").buttonset("refresh");
}


