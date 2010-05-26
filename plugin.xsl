<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="text" />


<xsl:template match="//plugin" mode="javascript">
	<xsl:variable name="pluginId" select="id/text()" />
	function Plugin_<xsl:value-of select="$pluginId" />() {
		this.inheritFrom = Plugin;
		this.inheritFrom("<xsl:value-of select="$pluginId" />", "<xsl:value-of select="normalize-space(name//text())" />");
		
		this.init = function() {
			<xsl:value-of select="init/text()" />
		};
		
		this.onResume = function() {
			<xsl:value-of select="resume/text()" />
		};
		
		this.onSuspend = function() {
			<xsl:value-of select="suspend/text()" />
		};
		
		<xsl:for-each select="method">
			this.<xsl:value-of name="name" select="@name" />
				= function(<xsl:value-of select="@parameters" />) {
				<xsl:apply-templates />
			}
		</xsl:for-each>
	}
</xsl:template>

</xsl:stylesheet>
