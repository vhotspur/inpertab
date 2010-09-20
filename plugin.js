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
	this.setPTE = function(pte) {
		this.pte = pte;
	};
	this.init = function() {
	};
	
	this.dump_ = function(obj, level) {
		var out = "";
		
		var padding = "";
		for (var j = -1; j < level; j++) {
			padding += "   ";
		}
		
		if (typeof obj == 'object') {
			for (var item in obj) {
				var value = obj[item];
				if (typeof value == 'object') {
					out += padding + "'" + item
						+ "' => ...\n";
					out += this.dump_(value, level + 1);
				} else {
					out += padding + "'" + item + "' => '"
						+ value + "'\n";
				}
			}
		} else {
			out += "'" + obj + "'";
		}
		
		return out;
	};
	
	this.dump = function(what) {
		var s = this.dump_(what, 0);
		$("#dump").text(s);
	};
	
	this.bindTextInputChanges = function(ctrl, func) {
		$(ctrl).change(func);
		$(ctrl).keypress(func);
		$(ctrl).keydown(func);
		$(ctrl).keyup(func);
	};
}


