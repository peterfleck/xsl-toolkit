<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template name="copyright">
	<xsl:param name="start" select="2010" />
	<xsl:value-of select="$start" />
	<xsl:if test="$this-year != $start">
		<xsl:text>&#8211;</xsl:text>
		<xsl:value-of select="$this-year" />
	</xsl:if>
</xsl:template>

</xsl:stylesheet>