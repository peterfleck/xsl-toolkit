<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:gesmes="http://www.gesmes.org/xml/2002-08-01"
	xmlns:eurofxref="http://www.ecb.int/vocabulary/2002-08-01/eurofxref">

<!-- Example Call

	<xsl:call-template name="currency-converter">
		<xsl:with-param name="value" select="'1'" />
		<xsl:with-param name="from" select="'EUR'" />
		<xsl:with-param name="to" select="'USD'" />
	</xsl:call-template>

-->

<xsl:template name="currency-converter">
	<xsl:param name="value" />
	<xsl:param name="from" />
	<xsl:param name="to" />
	<xsl:variable name="nodeset" select="document('http://www.ecb.int/stats/eurofxref/eurofxref-daily.xml')/gesmes:Envelope/eurofxref:Cube/*" />

	<xsl:variable name="rate-from">
		<xsl:choose>
			<xsl:when test="$from='EUR'">1</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$nodeset/eurofxref:Cube[@currency=$from]/@rate" />
			</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="rate-to">
		<xsl:choose>
			<xsl:when test="$to='EUR'">1</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$nodeset/eurofxref:Cube[@currency=$to]/@rate" />
			</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>

	<xsl:value-of select="$value div $rate-from * $rate-to" />
</xsl:template>

</xsl:stylesheet>