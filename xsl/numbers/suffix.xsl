<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <!--
        Suffix
        ===============================================================================
        Puts a suffix after a number:
        1 becomes 1st
        5 becomes 5th
        302 becomes 302nd

        Usage:

        <xsl:call-template name="suffix">
            <xsl:with-param name="number" select="xpath/to/my/number" />
            <xsl:with-param name="sup" select="true()" />
        </xsl:call-template>

        ===============================================================================
        The parameter 'sup' determines if the suffix should be shown in a <sup>-element
    -->

    <xsl:template name="suffix">
        <xsl:param name="number" />
        <xsl:param name="sup" select="false()" />

        <xsl:value-of select="$number" />

        <!-- Get the last number: -->
        <xsl:variable name="suffix">
            <xsl:choose>
                <xsl:when test="$number mod 10 = 1 and ($number &lt; 10 or $number &gt; 20)">st</xsl:when>
                <xsl:when test="$number mod 10 = 2 and ($number &lt; 10 or $number &gt; 20)">nd</xsl:when>
                <xsl:when test="$number mod 10 = 3 and ($number &lt; 10 or $number &gt; 20)">rd</xsl:when>
                <xsl:otherwise>th</xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <xsl:choose>
            <xsl:when test="$sup">
                <sup>
                    <xsl:value-of select="$suffix" />
                </sup>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$suffix" />
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

</xsl:stylesheet>