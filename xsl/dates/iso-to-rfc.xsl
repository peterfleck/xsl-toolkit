<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:date="http://exslt.org/dates-and-times"
	xmlns:str="http://exslt.org/strings"
	extension-element-prefixes="str date">
	
	<!--
	
	Convert an ISO date to an RFC date
	============================================================================
	version:	0.1
	author:		Twisted
	website:	www.twisted.nl
	============================================================================
	
	Converts an ISO date to a RFC 822 date:
	
		2010-08-31 11:04	»	Tue, 31 Aug 2010 11:04:00 GMT
	
	usage:
	
		<xsl:call-template name="iso-to-rfc">
			<xsl:with-param name="date" select="$today" />
			<xsl:with-param name="time" select="$current-time" />
		</xsl:call-template>
	
	or if you have a date element with the time-attribute available:
	
		<xsl:call-template name="iso-to-rfc">
			<xsl:with-param name="date" select="my-date-element" />
		</xsl:call-template>
	
	-->
	
	
	
	<!-- Function to convert an ISO date to a RFC 882 date: -->
	<xsl:template name="iso-to-rfc">
		<!-- Required parameters: -->
		<xsl:param name="date" />
		
		<!-- Optional parameters: -->
		<xsl:param name="time" />
		
		<!-- Do the magic: -->
		<!-- Check if time is 00:00:00-format and not 00:00 -->
		<xsl:param name="timeRFC">
			<xsl:choose>
				<xsl:when test="$time = ''">
					<xsl:choose>
						<xsl:when test="$date/@time = ''">
							<xsl:value-of select="'00:00:00'" />
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="concat($date/@time, ':00')" />
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:when test="count(str:split($time, ':')) = 2">
					<xsl:value-of select="concat($time, ':00')" />
				</xsl:when>		
				<xsl:otherwise>
					<xsl:value-of select="$time" />
				</xsl:otherwise>
			</xsl:choose>
		</xsl:param>
		
		<!-- Create the timestamp: -->
		<xsl:param name="rfcDate" select="concat(date:day-abbreviation($date), ', ',
			date:day-in-month($date), ' ', date:month-abbreviation($date), ' ',
			date:year($date), ' ', format-number(date:hour-in-day($timeRFC), '00'), ':',
			format-number(date:minute-in-hour($timeRFC), '00'), ':',
			format-number(date:second-in-minute($timeRFC), '00'), ' GMT')" />
		
		<xsl:value-of select="$rfcDate" />
	</xsl:template>
</xsl:stylesheet>