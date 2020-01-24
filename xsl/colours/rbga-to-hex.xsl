<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    
    <xsl:template name="rbga-to-hex">
        <xsl:param name="rgba-val"/>
        <xsl:param name="count" select="1"/>
        <xsl:variable name="val" select="substring-before($rgba-val,',')"/>
        <xsl:variable name="tail" select="substring-after($rgba-val,concat($val,','))"/>
        
        <xsl:choose>
            <xsl:when test="$count &lt; 4">
                <xsl:call-template name="to-hex">
                    <xsl:with-param name="val" select="$val"/>
                </xsl:call-template>
                <xsl:call-template name="rbga-to-hex">
                    <xsl:with-param name="count" select="$count + 1"/>
                    <xsl:with-param name="rgba-val" select="$tail"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
                <xsl:call-template name="to-hex">
                    <xsl:with-param name="val" select="$val"/>
                </xsl:call-template>				
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template name="to-hex">
        <xsl:param name="val"/>
        <xsl:param name="max" select="255"/>
        <xsl:param name="min" select="0"/>
        <xsl:param name="hex-key" select="'0123456789ABCDEF'"/>
        
        <!-- REMOVE NON-NUMERIC CHARACTERS -->
        <xsl:variable name="val"
            select="translate($val,'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ,.-_=+!@#$%^*() ','')"/>
        
        <!-- insure that the rgb value is within 0-255 -->
        <xsl:variable name="num">
            <xsl:choose>
                
                <xsl:when test="$val &gt; $max">
                    <xsl:value-of select="$max"/>
                </xsl:when>
                
                <xsl:when test="$val &lt; $min">
                    <xsl:value-of select="$min"/>
                </xsl:when>
                
                <!-- insure that we have whole numbers -->
                <xsl:otherwise>
                    <xsl:value-of select="round($val)"/>
                </xsl:otherwise>
                
            </xsl:choose>
        </xsl:variable>
        
        <!-- Return Hex Val -->
        <!-- substring(string, position, length) -->
        <xsl:value-of select="concat( substring($hex-key,(ceiling(($num - ceiling($num mod 16)) div 16)+1),1),
            substring($hex-key,(ceiling(($num - ceiling($num mod 16)) div 16)+1),1)
            )"/>
        
    </xsl:template>
    
    
</xsl:stylesheet>