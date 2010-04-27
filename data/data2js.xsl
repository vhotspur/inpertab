<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:kdeedu="http://www.xml-cml.org/schema">
<xsl:output method="text" />

<xsl:variable name="NL">
<xsl:text>
</xsl:text>
</xsl:variable>


<xsl:template match="/elements">
	<xsl:text>ELEMENTS = new Array(</xsl:text>
	<xsl:value-of select="$NL " />
	
	<xsl:for-each select="element">
		<xsl:apply-templates select="." />
		<xsl:if test="position() &lt; last()">
			<xsl:text>,</xsl:text>
		</xsl:if>
	</xsl:for-each>
	
	<xsl:text>);</xsl:text>
	<xsl:value-of select="$NL " />
</xsl:template>

<xsl:template match="element">
	<xsl:text>	new Array(</xsl:text>
	
	<!-- symbol (id) -->
	<xsl:text>"</xsl:text>
	<xsl:value-of select="@id" />
	<xsl:text>"</xsl:text>
	
	<!-- names -->
	<xsl:text>, "</xsl:text>
	<xsl:value-of select="name" />
	<xsl:text>"</xsl:text>
	
	<!-- discovery -->
	<xsl:text>, new Array(</xsl:text>
	<xsl:value-of select="discovery/date" />
	<xsl:text>, "</xsl:text>
	<xsl:value-of select="discovery/person" />
	<xsl:text>", "</xsl:text>
	<xsl:value-of select="discovery/country" />
	<xsl:text>")</xsl:text>
	
	<!-- oxidation states -->
	<xsl:text>, [</xsl:text>
	<xsl:for-each select="oxidation-states/oxidation-state">
		<xsl:value-of select="." />
		<xsl:if test="position() &lt; last()">
			<xsl:text>, </xsl:text>
		</xsl:if>
	</xsl:for-each>
	<xsl:text>]</xsl:text>
	
	<!-- atomic number and mass -->
	<xsl:text>, "</xsl:text>
	<xsl:value-of select="atomic-number" />
	<xsl:text>", "</xsl:text>
	<xsl:value-of select="mass" />
	<xsl:text>"</xsl:text>
	
	
	<xsl:text>)</xsl:text>
	<xsl:value-of select="$NL " />
</xsl:template>

</xsl:stylesheet>
