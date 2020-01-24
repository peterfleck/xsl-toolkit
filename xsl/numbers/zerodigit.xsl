<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<!--
		Zero Digit
		=======================================================================
		Version:		0.1
		Author:			Twisted
		Website:		www.twisted.nl
		Description:	Adds leading zero's to the digit n times.
		
		Example (convert '7' to '007'):
		
		<xsl:call-template name="zerodigit">
			<xsl:with-param name="number" select="7" />
			<xsl:with-param name="length" select="3" />
		</xsl:call-template>
		
		Optional: don't use zero's but a custom character:
		
		<xsl:call-template name="zerodigit">
			<xsl:with-param name="number" select="13" />
			<xsl:with-param name="length" select="5" />
			<xsl:with-param name="character" select="'*'" />
		</xsl:call-template>
		
		Outputs: '***13'
	-->	
	<xsl:template name="zerodigit">
		<!-- Parameters: -->
		<xsl:param name="number" />
		<xsl:param name="length" select="2" />
		<xsl:param name="character" select="0" />
		
		<!-- Call the template recursive: -->
		<xsl:call-template name="zerodigit-zero">
			<xsl:with-param name="maxLength" select="$length - string-length($number)" />
			<xsl:with-param name="currentPos" select="0" />
			<xsl:with-param name="character" select="$character" />
		</xsl:call-template>
		<!-- Add the original number: -->
		<xsl:value-of select="$number" />
	</xsl:template>
	
	<!-- For internal use (recursive template loop): -->
	<xsl:template name="zerodigit-zero">
		<xsl:param name="currentPos" />
		<xsl:param name="maxLength" />
		<xsl:param name="character" />
		<xsl:if test="$currentPos &lt; $maxLength">
			<xsl:value-of select="$character" />
			<xsl:call-template name="zerodigit-zero">
				<xsl:with-param name="maxLength" select="$maxLength" />
				<xsl:with-param name="currentPos" select="$currentPos + 1" />
				<xsl:with-param name="character" select="$character" />
			</xsl:call-template>
		</xsl:if>
	</xsl:template>
</xsl:stylesheet>