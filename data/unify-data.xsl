<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:kdeedu="http://www.xml-cml.org/schema">
<xsl:output method="xml" indent="yes" />

<xsl:variable name="CHEMICAL_ELEMENTS">
H He Li Be B C N O F Ne Na Mg Al Si P S Cl Ar K Ca Sc Ti V Cr Mn Fe Co Ni
Cu Zn Ga Ge As Se Br Kr Rb Sr Y Zr Nb Mo Tc Ru Rh Pd Ag Cd In Sn Sb Te I
Xe Cs Ba La Ce Pr Nd Pm Sm Eu Gd Tb Dy Ho Er Tm Yb Lu Hf Ta W Re Os Ir Pt
Au Hg Tl Pb Bi Po At Rn Fr Ra Ac Th Pa U Np Pu Am Cm Bk Cf Es Fm Md No Lr
Rf Db Sg Bh Hs Mt Ds Rg Uub Uut Uuq Uup Uuh Uus Uuo
</xsl:variable>

<xsl:template match="/">

	<elements>
		<xsl:call-template name="processRemainingElements">
			<xsl:with-param name="elements" select="$CHEMICAL_ELEMENTS" />
		</xsl:call-template>
	</elements>

</xsl:template>


<xsl:template name="processRemainingElements">
	<xsl:param name="elements" />
	
	<xsl:variable name="_elements" select="concat(normalize-space($elements), ' ')" />
	<xsl:variable name="first" select="substring-before($_elements, ' ')" />
	<xsl:variable name="remainder" select="substring-after($_elements, ' ')" />
	
	<xsl:if test="$_elements != ' '">
		<xsl:call-template name="processElement">
			<xsl:with-param name="element" select="$first" />
		</xsl:call-template>
		
		<xsl:call-template name="processRemainingElements">
			<xsl:with-param name="elements" select="$remainder" />
		</xsl:call-template>
	</xsl:if>
</xsl:template>


<xsl:template name="processElement">
	<xsl:param name="element" />

	<xsl:variable name="info1" select="//kdeedu:atom[@id = $element]" />
	<xsl:variable name="info2" select="//ATOM[SYMBOL/text() = $element]" />
	<xsl:variable name="info3" select="//element-names/element[@symbol = $element]" />

	<xsl:element name="element">
		<xsl:attribute name="id">
			<xsl:value-of select="$element" />
		</xsl:attribute>

		<names>
			<name lang="en">
				<xsl:apply-templates select="$info1/kdeedu:label[@dictRef='bo:name']/@value" />
			</name>
			<name lang="univ">
				<xsl:value-of select="$info3/name[@lang='univ']" />
			</name>
			<name lang="cz">
				<xsl:value-of select="$info3/name[@lang='cz']" />
			</name>
		</names>

		<atomic-number>
			<xsl:value-of select="$info1/kdeedu:scalar[@dictRef='bo:atomicNumber']/text()" />
		</atomic-number>
		
		<mass>
			<xsl:value-of select="$info1/kdeedu:scalar[@dictRef='bo:exactMass']/text()" />
		</mass>
		
		<period>
			<xsl:value-of select="$info1/kdeedu:scalar[@dictRef='bo:period']/text()" />
		</period>
		<group>
			<xsl:value-of select="$info1/kdeedu:scalar[@dictRef='bo:group']/text()" />
		</group>
		
		<discovery>
			<country>
				<xsl:value-of select="$info1/kdeedu:array[@dictRef='bo:discoveryCountry']/text()" />
			</country>
			<date>
				<xsl:value-of select="$info1/kdeedu:scalar[@dictRef='bo:discoveryDate']/text()" />
			</date>
			<person>
				<xsl:value-of select="$info1/kdeedu:array[@dictRef='bo:discoverers']/text()" />
			</person>
		</discovery>
		
		<density>
			<xsl:value-of select="normalize-space($info2/DENSITY/text())" />
		</density>
		
		<oxidation-states>
			<xsl:call-template name="commaDelimitedToElements">
				<xsl:with-param name="input">
					<xsl:call-template name="strReplaceFromList">
						<xsl:with-param name="where" select="$info2/OXIDATION_STATES/text()" />
						<xsl:with-param name="what" select="'+/-1@+/-2@+/-3@+/-4@+/-5@+/-6@+/-7@+/-8'" />
						<xsl:with-param name="replacement" select="'1,-1@2,-2@3,-3@4,-4@5,-5@6,-6@7,-7@8,-8'" />
					</xsl:call-template>
				</xsl:with-param>
				<xsl:with-param name="wrappingElement" select="'oxidation-state'" />
			</xsl:call-template>
		</oxidation-states>
		
		<state-of-matter>
			<boiling-point unit="kelvin">
				<xsl:value-of select="$info1/kdeedu:scalar[@dictRef='bo:boilingpoint']/text()" />
			</boiling-point>
			<melting-point unit="kelvin">
				<xsl:value-of select="$info1/kdeedu:scalar[@dictRef='bo:meltingpoint']/text()" />
			</melting-point>
		</state-of-matter>
		
		<electronic-configuration>
			<xsl:value-of select="$info1/kdeedu:scalar[@dictRef='bo:electronicConfiguration']/text()" />
		</electronic-configuration>
		
	</xsl:element>
</xsl:template>


<xsl:template name="commaDelimitedToElements">
	<xsl:param name="input" />
	<xsl:param name="wrappingElement" />
	<xsl:param name="comma" select="','" />
	<!--<xsl:message>
		<xsl:value-of select="$input" />
	</xsl:message-->
	
	<xsl:variable name="_input" select="concat(normalize-space($input), $comma)" />
	
	<xsl:variable name="first" select="substring-before($_input, $comma)" />
	<xsl:variable name="remain" select="substring-after($_input, $comma)" />
	
	<xsl:if test="$first != ''">
		<xsl:element name="{$wrappingElement}">
			<xsl:value-of select="normalize-space($first)" />
		</xsl:element>
		
		<xsl:call-template name="commaDelimitedToElements">
			<xsl:with-param name="input" select="$remain" />
			<xsl:with-param name="wrappingElement" select="$wrappingElement" />
			<xsl:with-param name="comma" select="$comma" />
		</xsl:call-template>
	</xsl:if>
	
</xsl:template>


<!---
Multiple pattern replacement.

@warning
The template does not check that both @p REPLACEMENT and @p WHAT
contains same number of tokens to replace.
 
-->
<xsl:template name="strReplaceFromList">
	<!--- string Source. -->
	<xsl:param name="where" />
	<!--- string List of patterns to be replaced, delimited by @p whatDelim. -->
	<xsl:param name="what" />
	<!--- string Item delimiter for @p what. -->
	<xsl:param name="whatDelim" select="'@'" />
	<!--- string List of replacement patterns, delimited by @p replacementDelim. -->
	<xsl:param name="replacement" />
	<!--- string Item delimiter for @p replacement. -->
	<xsl:param name="replacementDelim" select="'@'" />
	
	<xsl:choose>
		<!--- nothing more to replace -->
		<xsl:when test="string-length($what)=0"><xsl:value-of select="$where" /></xsl:when>
		<!--- only one token remains in what -->
		<xsl:when test="not(contains($what, $whatDelim))">
			<xsl:call-template name="strReplaceG">
				<xsl:with-param name="where" select="$where" />
				<xsl:with-param name="what" select="$what" />
				<xsl:with-param name="replacement" select="$replacement" />
			</xsl:call-template>
		</xsl:when>
		<!-- otherwise, take the first tokens and run recursively -->
		<xsl:otherwise>
			<!-- split the $what and $replacement - take the first ones -->
			<xsl:variable name="firstWhat" select="substring-before($what, $whatDelim)" />
			<xsl:variable name="whatRest" select="substring-after($what, $whatDelim)" />
			<xsl:variable name="firstReplacement" select="substring-before($replacement, $replacementDelim)" />
			<xsl:variable name="replacementRest" select="substring-after($replacement, $replacementDelim)" />
			<!-- store the result of replacement with the first one -->
			<xsl:variable name="partialResult">
				<xsl:call-template name="strReplaceG">
					<xsl:with-param name="where" select="$where" />
					<xsl:with-param name="what" select="$firstWhat" />
					<xsl:with-param name="replacement" select="$firstReplacement" />
				</xsl:call-template>
			</xsl:variable>
			<!-- and call self recursively with the rest -->
			<xsl:call-template name="strReplaceFromList">
				<xsl:with-param name="where" select="$partialResult" />
				<xsl:with-param name="what" select="$whatRest" />
				<xsl:with-param name="whatDelim" select="$whatDelim" />
				<xsl:with-param name="replacement" select="$replacementRest" />
				<xsl:with-param name="replacementDelim" select="$replacementDelim" />
			</xsl:call-template>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>	


<!---
Replaces all substrings in a string.
-->
<xsl:template name="strReplaceG">
	<!--- string Source. -->
	<xsl:param name="where" />
	<!--- string String to be replaced. -->
	<xsl:param name="what" />
	<!--- string Replacement string. -->
	<xsl:param name="replacement" />
	
	<xsl:choose>
		<xsl:when test="string-length($where)=0"></xsl:when>
		<xsl:when test="$where=$what"><xsl:value-of select="$replacement" /></xsl:when>
		<xsl:when test="(substring-after($where, $what)='') and (substring-before($where, $what)='')"
			><xsl:value-of select="$where" /></xsl:when>
		<xsl:otherwise><xsl:value-of
			select="substring-before($where, $what)" /><xsl:value-of
			select="$replacement" /><xsl:call-template name="strReplaceG">
				<xsl:with-param name="where" select="substring-after($where, $what)" />
				<xsl:with-param name="what" select="$what" />
				<xsl:with-param name="replacement" select="$replacement" />
			</xsl:call-template></xsl:otherwise>
	</xsl:choose>
</xsl:template>


</xsl:stylesheet>
