<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  
  <!-- What is this utility all about? This utility converts a decimal number to a fraction. 
  This work is licensed under a Creative Commons Attribution-ShareAlike 3.0 Unported License.-->
  
  <!-- Example Call
  <xsl:call-template name="decimal-to-fraction">
    <xsl:with-param name="decimalnum" select="0.5"/>
  </xsl:call-template>
  -->
  

  <xsl:template name="decimal-to-fraction">
    <xsl:param name="decimalnum"/>
    <xsl:param name="num" select="round($decimalnum * 1000)"/> <!-- numerator -->
    <xsl:param name="dom" select="round(1000)"/> <!-- denominator -->
    <xsl:param name="gcd"> <!-- greatest common divisor aka highest common factor -->
      <xsl:call-template name="greatest-common-divisor">
        <xsl:with-param name="num" select="$num"/>
        <xsl:with-param name="dom" select="$dom"/>
      </xsl:call-template>
    </xsl:param>
    <xsl:value-of select="$num div $gcd"/>/<xsl:value-of select="$dom div $gcd"/>
  </xsl:template>
  
  <xsl:template name="greatest-common-divisor">
    <xsl:param name="num"/>
    <xsl:param name="dom"/>
    <xsl:choose>
      <xsl:when test="$num &lt; 0">
        <!-- Call GCD with positive num -->
        <xsl:call-template name="GCD">
          <xsl:with-param name="num" select="-$num"/>
          <xsl:with-param name="dom" select="$dom"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:when test="$dom &lt; 0">
        <!-- Call GCD with positive dom -->
        <xsl:call-template name="GCD">
          <xsl:with-param name="num" select="$num"/>
          <xsl:with-param name="dom" select="-$dom"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:when test="$num + $dom &gt; 0">
        <!-- Valid input, call GCD-helper -->
        <xsl:call-template name="greatest-common-divisor-helper">
          <xsl:with-param name="gcd" select="$dom"/>
          <xsl:with-param name="num" select="$num"/>
          <xsl:with-param name="dom" select="$dom"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <!-- Error, both parameters zero -->
        <xsl:text>error</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <xsl:template name="greatest-common-divisor-helper">
    <!-- Recursive template. Call until $num = 0. -->
    <xsl:param name="gcd"/>
    <xsl:param name="num"/>
    <xsl:param name="dom"/>
    <xsl:choose>
      <xsl:when test="$num &gt; 0">
        <!-- Recursive call -->
        <xsl:call-template name="greatest-common-divisor-helper">
          <xsl:with-param name="gcd" select="$num"/>
          <xsl:with-param name="num" select="$dom mod $num"/>
          <xsl:with-param name="dom" select="$num"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$gcd"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
</xsl:stylesheet>