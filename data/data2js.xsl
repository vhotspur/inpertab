<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:kdeedu="http://www.xml-cml.org/schema">
<xsl:output method="text" />

<xsl:variable name="NL">
<xsl:text>
</xsl:text>
</xsl:variable>


<xsl:template match="/elements">
	<xsl:text>function InitializeChemicalElements(pte) {</xsl:text>
	<xsl:value-of select="$NL " />
	
	<xsl:for-each select="element">
		<xsl:apply-templates select="." />
		<!--<xsl:if test="position() &lt; last()">
			<xsl:text>;</xsl:text>
		</xsl:if>-->
	</xsl:for-each>
	
	<xsl:text>};</xsl:text>
	<xsl:value-of select="$NL " />
</xsl:template>

<xsl:template match="element">
	<xsl:text>	pte.addElement(new ChemElement( {</xsl:text>
	
	<!-- symbol (id) -->
	<xsl:text>symbol : "</xsl:text>
	<xsl:value-of select="@id" />
	<xsl:text>",</xsl:text>
	
	<!-- names -->
	<xsl:text>localName : "</xsl:text>
	<xsl:value-of select="name" />
	<xsl:text>",</xsl:text>
	
	<!-- discovery -->
	<xsl:text>discoveryYear : </xsl:text>
	<xsl:value-of select="discovery/date" />
	<xsl:text>, discoveryPeople: "</xsl:text>
	<xsl:value-of select="discovery/person" />
	<xsl:text>", discoveryCountries: "</xsl:text>
	<xsl:value-of select="discovery/country" />
	<xsl:text>",</xsl:text>
	
	<!-- oxidation states -->
	<xsl:text>oxidationStates : [</xsl:text>
	<xsl:for-each select="oxidation-states/oxidation-state">
		<xsl:value-of select="." />
		<xsl:if test="position() &lt; last()">
			<xsl:text>, </xsl:text>
		</xsl:if>
	</xsl:for-each>
	<xsl:text>],</xsl:text>
	
	<!-- atomic number and mass -->
	<xsl:text>atomicNumber : "</xsl:text>
	<xsl:value-of select="atomic-number" />
	<xsl:text>", mass: "</xsl:text>
	<xsl:value-of select="mass" />
	<xsl:text>",</xsl:text>
	
	<xsl:text>xxxxxx : 0</xsl:text>
	
	<xsl:text>}));</xsl:text>
	<xsl:value-of select="$NL " />
</xsl:template>

</xsl:stylesheet>
