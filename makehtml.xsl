<?xml version="1.0"?>
<!DOCTYPE stylesheet SYSTEM "l10n.dtd">
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html" indent="yes" />


<xsl:template match="/periodic-table">
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
		<title>&tr_title;</title>
		<link type="text/css" href="css/sunny/jquery-ui-1.8.custom.css" rel="stylesheet" />	
		<link type="text/css" href="table.css" rel="stylesheet" />	
		<script type="text/javascript" src="js/jquery-1.4.2.min.js"></script>
		<script type="text/javascript" src="js/jquery-ui-1.8.custom.min.js"></script>
		<script type="text/javascript" src="data.js"></script>
		<script type="text/javascript" src="periodic.js"></script>
		<script type="text/javascript" src="element.js"></script>
		<script type="text/javascript" src="pte.js"></script>
		<script type="text/javascript" src="plugin.js"></script>
		<script type="text/javascript" src="oxidationstates.js"></script>
		<script type="text/javascript" src="discovery.js"></script>
		<script type="text/javascript">
		$(function() {
			onDocumentLoaded();			
		});	
		</script>
	</head>
	<body>
		<table id="pte" >
			<xsl:apply-templates />
		</table>
		<div id="ctrl-show-plugins">
			
		</div>
	</body>
</html>
</xsl:template>

<xsl:template match="row">
	<tr>
		<xsl:apply-templates />
	</tr>
</xsl:template>

<xsl:template match="blank-cell">
	<xsl:call-template name="printCell" />
</xsl:template>

<xsl:template match="header-cell">
	<xsl:call-template name="printCell" />
</xsl:template>

<xsl:template match="cell">
	<xsl:call-template name="printCell" />
</xsl:template>

<xsl:template match="element-cell">
	<xsl:call-template name="printCell" />
</xsl:template>

<xsl:template name="printCell">
	<xsl:param name="cell" select="." />
	
	<xsl:variable name="elementName">
		<xsl:choose>
			<xsl:when test="name($cell) = 'header-cell'">th</xsl:when>
			<xsl:otherwise>td</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	
	<xsl:element name="{$elementName}">
		<xsl:if test="$cell/@col-span">
			<xsl:attribute name="colspan">
				<xsl:value-of select="$cell/@col-span" />
			</xsl:attribute>
		</xsl:if>
		<xsl:if test="$cell/@row-span">
			<xsl:attribute name="rowspan">
				<xsl:value-of select="$cell/@row-span" />
			</xsl:attribute>
		</xsl:if>
		<xsl:if test="$cell/@id">
			<xsl:attribute name="id">
				<xsl:value-of select="$cell/@id" />
			</xsl:attribute>
		</xsl:if>
		<xsl:if test="name($cell) = 'element-cell'">
			<xsl:attribute name="class">
				<xsl:text>element</xsl:text>
			</xsl:attribute>
		</xsl:if>
		<xsl:if test="(name($cell) = 'blank-cell') or (name($cell) = 'cell')">
			<xsl:attribute name="class">
				<xsl:text>blank</xsl:text>
			</xsl:attribute>
		</xsl:if>
		
		<xsl:apply-templates select="$cell/*|$cell/text()" />
		
	</xsl:element>

</xsl:template>

<xsl:template match="controls-placeholder">
	<xsl:choose>
		<xsl:when test="@name = 'main'">
			<div class="plugin-board" id="plugin-board-discovery">
				Elements known before <span id="p-discovery-label-year">1700</span>
				<div style="" id="p-discovery-ctrl-year"></div>
			</div>
			
			<div class="plugin-board" id="plugin-board-oxidationstates">
				<div id="p-oxidationstates-radio">
					<input type="radio" name="p-oxidationstates-state" value="-4" id="p-oxidationstates-st--4" />
						<label for="p-oxidationstates-st--4">-IV</label>
					<input type="radio" name="p-oxidationstates-state" value="-3" id="p-oxidationstates-st--3" />
						<label for="p-oxidationstates-st--3">-III</label>
					<input type="radio" name="p-oxidationstates-state" value="-2" id="p-oxidationstates-st--2" />
						<label for="p-oxidationstates-st--2">-II</label>
					<input type="radio" name="p-oxidationstates-state" value="-1" id="p-oxidationstates-st--1" />
						<label for="p-oxidationstates-st--1">-I</label>
					<input type="radio" name="p-oxidationstates-state" value="1" id="p-oxidationstates-st-1" />
						<label for="p-oxidationstates-st-1">I</label>
					<input type="radio" name="p-oxidationstates-state" value="2" id="p-oxidationstates-st-2" />
						<label for="p-oxidationstates-st-2">II</label>
					<input type="radio" name="p-oxidationstates-state" value="3" id="p-oxidationstates-st-3" />
						<label for="p-oxidationstates-st-3">III</label>
					<input type="radio" name="p-oxidationstates-state" value="4" id="p-oxidationstates-st-4" />
						<label for="p-oxidationstates-st-4">IV</label>
					<input type="radio" name="p-oxidationstates-state" value="5" id="p-oxidationstates-st-5" />
						<label for="p-oxidationstates-st-5">V</label>
					<input type="radio" name="p-oxidationstates-state" value="6" id="p-oxidationstates-st-6" />
						<label for="p-oxidationstates-st-6">VI</label>
					<input type="radio" name="p-oxidationstates-state" value="7" id="p-oxidationstates-st-7" />
						<label for="p-oxidationstates-st-7">VII</label>
					<input type="radio" name="p-oxidationstates-state" value="8" id="p-oxidationstates-st-8" />
						<label for="p-oxidationstates-st-8">VIII</label>
				</div>
			</div>
			
			<div id="dialog-element-details">
				<div id="tabs-element-details">
					<ul>
						<li><a href="#element-details-basic">&tr_eleminfo_basic;</a></li>
						<li><a href="#element-details-isotopes">Isotopes</a></li>
						<li><a href="#element-details-states-of-matter">State of matter</a></li>
					</ul>
					<div id="element-details-basic">
						<table width="100%" border="0">
						<tr>
							<td width="50%" class="element-details-icon">
								<span id="element-details-icon">
									<sub class="element-details-atomic-number"></sub>
									<span class="element-details-symbol">?</span>
								</span>
								<br />
								<span class="element-details-mass">?</span>
							</td>
							<td width="50%">
								<dl>
									<dt>Universal name</dt>
										<dd class="element-details-universal-name">?</dd>
									<dt>Name</dt>
										<dd class="element-details-name">?</dd>
									<dt>English name</dt>
										<dd class="element-details-english-name">?</dd>
									<dt>Period - group</dt>
										<dd>
											<span class="element-details-period">0</span>
											-
											<span class="element-details-group">0</span>
										</dd>
								</dl>
							</td>
						</tr>
						</table>
					</div>
					<div id="element-details-isotopes">
						<ul id="element-details-isotope-list">
						</ul>
					</div>
					<div id="element-details-states-of-matter">
						<dl>
							<dt>Boiling point</dt>
								<dd>
									<span class="element-details-boiling-point-kelvin">?</span>K
									(<span class="element-details-boiling-point-celsius">?</span>°C)
								</dd>
							<dt>Melting point</dt>
								<dd>
									<span class="element-details-melting-point-kelvin">?</span>K
									(<span class="element-details-melting-point-celsius">?</span>°C)
								</dd>
						</dl>
					</div>
				</div>
			</div>
		</xsl:when>
		<xsl:when test="@name = 'tiny'">
			
		</xsl:when>
		<xsl:otherwise>
			<xsl:value-of select="@name" />
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

</xsl:stylesheet>
