
function FormulaToken(kind, data) {
	this.kind = kind;
	this.data = data;
}

function ChemicalFormula(pte, formula) {
	
	this.pte = pte;
	
	this.TOK_END = 0;
	this.TOK_ELEMENT = 1;
	this.TOK_NUMBER = 2;
	this.TOK_OPENPAR = 3;
	this.TOK_CLOSEPAR = 4;
	
	this.charIsIn = function(c, lower, upper) {
		return (c >= lower) && (c <= upper);
	}
	
	this.charIsUpper = function(c) {
		return this.charIsIn(c, 'A', 'Z');
	}
	this.charIsLower = function(c) {
		return this.charIsIn(c, 'a', 'z');
	}
	this.charIsDigit = function(c) {
		return this.charIsIn(c, '0', '9');
	}
	
	this.tokenString_ = "";
	this.setTokenString = function(s) {
		this.tokenString_ = s + "#";
	}
	this.cutTokenString_ = function(cutIndex) {
		this.tokenString_ = this.tokenString_.substring(cutIndex,
			this.tokenString_.length);
	}
	this.makeNextToken_ = function(kind, data, cutIndex) {
		this.cutTokenString_(cutIndex);
		return new FormulaToken(kind, data);
	}
	/**
	 * @return Two member array - first member token info, second formula
	 * remainder.
	 */
	this.getNextToken = function() {
		if (this.tokenString_ == "") {
			return new FormulaToken(this.TOK_END, null);
		}
		var formula = this.tokenString_;
		var c = formula.charAt(0);
		if (this.charIsDigit(c)) {
			var number = c * 1;
			var i = 1;
			c = formula.charAt(i);
			while (this.charIsDigit(c)) {
				number = number * 10 + (c * 1);
				c = formula.charAt(++i);
			}
			return this.makeNextToken_(this.TOK_NUMBER, number, i);
		}
		if (this.charIsUpper(c)) {
			var element = c;
			var i = 1;
			while (this.charIsLower(formula.charAt(i))) {
				element += formula.charAt(i);
				i++;
			}
			var info = this.pte.getElementInfo(element);
			if (info == 0) {
				this.cutTokenString_(i);
				return this.getNextToken();
			}
			return this.makeNextToken_(this.TOK_ELEMENT, element, i);
		}
		if (c == '(') {
			return this.makeNextToken_(this.TOK_OPENPAR, null, 1);
		}
		if (c == ')') {
			return this.makeNextToken_(this.TOK_CLOSEPAR, null, 1);
		}
		this.cutTokenString_(1);
		// skip this char and try next
		return this.getNextToken();
	};
	
	this.parseSubformula_ = function() {
		var formula = new Array();
		var token = this.getNextToken();
		while (true) {
			if (token.kind == this.TOK_END) {
				return new Array(formula, token);
			}
			if (token.kind == this.TOK_ELEMENT) {
				var element = token.data;
				var count = 1;
				token = this.getNextToken();
				if (token.kind == this.TOK_NUMBER) {
					count = token.data;
					token = this.getNextToken();
				}
				formula[formula.length]
					= new Array(0, element, count);
				continue;
			}
			if (token.kind == this.TOK_OPENPAR) {
				var subparse = this.parseSubformula_();
				var subformula = subparse[0];
				token = subparse[1];
				if (token.kind != this.TOK_CLOSEPAR) {
					if (subformula.length > 0) {
						formula[formula.length]
							= new Array(1, subformula, 1);
					}
					return new Array(formula, token);
				}
				var count = 1;
				token = this.getNextToken();
				if (token.kind == this.TOK_NUMBER) {
					count = token.data;
					token = this.getNextToken();
				}
				formula[formula.length]
					= new Array(1, subformula, count);
				continue;
			}
			if (token.kind == this.TOK_CLOSEPAR) {
				return new Array(formula, token);
			}
			// skip this token
			token = this.getNextToken();
		}
	};
	
	this.parse_ = function(s) {
		this.setTokenString(s);
		
		var parsed = this.parseSubformula_();
		return parsed[0];
	};
	
	this.getTokens = function(s) {
		this.setTokenString(s);
		var token = this.getNextToken();
		var tokens = new Array();
		while (true) {
			var name = "unknown";
			if (token.kind == this.TOK_ELEMENT) {
				name = "element";
			} else if (token.kind == this.TOK_NUMBER) {
				name = "number";
			} else if (token.kind == this.TOK_OPENPAR) {
				name = "openpar";
			} else if (token.kind == this.TOK_CLOSEPAR) {
				name = "closepar";
			} else if (token.kind == this.TOK_END) {
				name = "end";
			}
			
			tokens[tokens.length] = name;
			
			if (token.kind == this.TOK_END) {
				break;
			}
			token = this.getNextToken();
		}
		return tokens.join(", ");
	};
	
	this.formula = this.parse_(formula);
	
	this.getFormula = function() {
		return this.formula;
	};
	
}
