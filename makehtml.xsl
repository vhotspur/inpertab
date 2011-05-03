<?xml version="1.0"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:l="http://github.com/vhotspur/sxmloc"
>
<xsl:import href="./plugin.xsl" />
<xsl:output method="html" indent="yes" />

<xsl:template match="/periodic-table-input">
	<xsl:apply-templates select="periodic-table" />
</xsl:template>


<xsl:template match="//periodic-table">
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
		<title><l:g>Periodic table</l:g></title>
		<link type="text/css" href="css/sunny/jquery-ui-1.8.custom.css" rel="stylesheet" />
		<link type="text/css" href="table.css" rel="stylesheet" />
		<style type="text/css">
			<xsl:for-each select="//plugin">
				<xsl:value-of select="css/text()" />
			</xsl:for-each>
		</style>
		<script type="text/javascript" src="js/jquery-1.4.2.min.js"></script>
		<script type="text/javascript" src="js/jquery-ui-1.8.custom.min.js"></script>
		<script type="text/javascript" src="data.js"></script>
		<script type="text/javascript" src="periodic.js"></script>
		<script type="text/javascript" src="element.js"></script>
		<script type="text/javascript" src="pte.js"></script>
		<script type="text/javascript" src="parser.js"></script>
		<script type="text/javascript" src="plugin.js"></script>
		<script type="text/javascript" src="home.js"></script>
		<script type="text/javascript">
		<xsl:apply-templates select="//plugin" mode="javascript" />
		PLUGINS = new Array();
		PLUGINS[0] = new Plugin_home();
		PLUGINS[0].name = "<l:g>Home</l:g>";
		$(function() {
			<xsl:for-each select="//plugin">
				PLUGINS[PLUGINS.length]
					= new Plugin_<xsl:value-of select="id/text()" />();
			</xsl:for-each>

			onDocumentLoaded();
		});
		</script>
	</head>
	<body>
		<table id="pte" width="100%">
			<xsl:apply-templates />
		</table>
		<div id="ctrl-show-plugins">
		</div>
		<pre id="dump"></pre>
	</body>
</html>
</xsl:template>

<xsl:template match="column-widths/width">
	<xsl:element name="colgroup">
		<xsl:attribute name="width">
			<xsl:value-of select="text()" />
		</xsl:attribute>
		<xsl:if test="@count">
			<xsl:attribute name="span">
				<xsl:value-of select="@count" />
			</xsl:attribute>
		</xsl:if>
	</xsl:element>
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
		<xsl:choose>
			<xsl:when test="name($cell) = 'element-cell'">
				<div class="pte-element-info">
					<span class="pte-element-above"><span></span><br /></span>
					<span class="pte-element-left"><span></span></span>
					<span class="pte-element-symbol">
						<xsl:apply-templates select="$cell/*|$cell/text()" />
					</span>
					<span class="pte-element-right"><span></span></span>
					<span class="pte-element-below"><br /><span></span></span>
				</div>
			</xsl:when>
			<xsl:otherwise>
				<span>
				<xsl:apply-templates select="$cell/*|$cell/text()" />
				</span>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:element>

</xsl:template>

<xsl:template match="controls-placeholder">
	<xsl:choose>
		<xsl:when test="@name = 'main'">
			<xsl:for-each select="//plugins/plugin">
				<xsl:variable name="pluginId" select="id/text()" />
				<xsl:element name="div">
					<xsl:attribute name="class">plugin-board</xsl:attribute>
					<xsl:attribute name="id">plugin-board-<xsl:value-of select="$pluginId" /></xsl:attribute>
					
					<xsl:apply-templates select="board/*|board/text()" mode="deep-copy" />
				</xsl:element>
			</xsl:for-each>
			
			<div class="plugin-board" id="plugin-board-home" style="text-align:left">
				<ul class="p-home-legend">
					<li><span class="element-family-alkalimetal"><l:g>alkali metal</l:g></span></li>
					<li><span class="element-family-alkalineearthmetal"><l:g>alkaline earth metal</l:g></span></li>
					<li><span class="element-family-metal"><l:g>metal</l:g></span></li>
					<li><span class="element-family-metalloid"><l:g>metalloid</l:g></span></li>
					<li><span class="element-family-nonmetal"><l:g>non-metal</l:g></span></li>
					<li><span class="element-family-noblegas"><l:g>noble gas</l:g></span></li>
				</ul>
			</div>
			
			<div id="dialog-element-details">
				<div id="tabs-element-details">
					<ul>
						<li><a href="#element-details-basic"><l:g>Basic data</l:g></a></li>
						<li><a href="#element-details-extra"><l:g>Other attributes</l:g></a></li>
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
									<dt><l:g>Universal name</l:g></dt>
										<dd class="element-details-universal-name">?</dd>
									<dt><l:g>Name</l:g></dt>
										<dd class="element-details-name">?</dd>
									<dt><l:g>English name</l:g></dt>
										<dd class="element-details-english-name">?</dd>
									<dt><l:g>Period - group</l:g></dt>
										<dd>
											<span class="element-details-period">0</span>
											-
											<span class="element-details-group">0</span>
										</dd>
									<dt><l:g>Electronegativity</l:g></dt>
										<dd>
											<span class="element-details-electronegativity">?</span>
										</dd>
								</dl>
							</td>
						</tr>
						</table>
					</div>
					<div id="element-details-extra">
						<dl>
							<dt><l:g>Boiling point</l:g></dt>
								<dd>
									<span class="element-details-boiling-point-kelvin">?</span>K
									(<span class="element-details-boiling-point-celsius">?</span>°C)
								</dd>
							<dt><l:g>Melting point</l:g></dt>
								<dd>
									<span class="element-details-melting-point-kelvin">?</span>K
									(<span class="element-details-melting-point-celsius">?</span>°C)

								</dd>
							<dt><l:g>Density</l:g></dt>
								<dd>
									<span class="element-details-density">?</span>
									g&#183;cm<sup>-3</sup>
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

<xsl:template match="*" mode="deep-copy">
	<xsl:copy>
		<xsl:copy-of select="@*" />
		<xsl:apply-templates mode="deep-copy" />
	</xsl:copy>
</xsl:template>

<xsl:template match="l:g">
	<xsl:apply-templates />
</xsl:template>

</xsl:stylesheet>
