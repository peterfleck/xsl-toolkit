<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:date="http://exslt.org/dates-and-times" extension-element-prefixes="date">

    <!--

USAGE:

		<xsl:variable name="exchange-rate">
			<xsl:call-template name="hmrc-exchange-rates">
				<xsl:with-param name="month" select="'05'"/>
        <xsl:with-param name="year" select="'19'/">
				<xsl:with-param name="currency" select="'USD'"/>
			</xsl:call-template>
		</xsl:variable>

If month or year is not passed, it will default to current date.
If no currency is passed, it will return all currencies on the HRMC list.

-->

    <xsl:output method="xml" omit-xml-declaration="yes" encoding="UTF-8" indent="yes" />

    <xsl:template name="hmrc-exchange-rates">
        <xsl:param name="month" select="date:month-in-year()" />
        <xsl:param name="year" select="substring(date:year(), 3, 2)" />
        <xsl:param name="currency" select="''" />

        <xsl:choose>
            <xsl:when test="$currency != ''">
                <xsl:copy-of select="document(concat('http://www.hmrc.gov.uk/softwaredevelopers/rates/exrates-monthly-',$month,$year,'.xml'))/exchangeRateMonthList/exchangeRate[currencyCode=$currency]" />
            </xsl:when>
            <xsl:otherwise>
                <xsl:copy-of select="document(concat('http://www.hmrc.gov.uk/softwaredevelopers/rates/exrates-monthly-',$month,$year,'.xml'))" />
            </xsl:otherwise>
        </xsl:choose>

    </xsl:template>
</xsl:stylesheet>
