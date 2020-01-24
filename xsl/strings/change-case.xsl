<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	
	<!--
		Examples:
		
		<xsl:call-template name="uppercase">
			<xsl:with-param name="value" select="'This text will be uppercase.'" />
		</xsl:call-template>
		
		<xsl:call-template name="lowercase">
			<xsl:with-param name="value" select="'THIS TEXT WILL BE LOWERCASE.'" />
		</xsl:call-template>
		
		<xsl:call-template name="ucfirst">
			<xsl:with-param name="value" select="'the first letter of this text will be uppercase.'" />
		</xsl:call-template>		
	-->
	
	<xsl:param name="smallcase" select="'abcdefghijklmnopqrstuvwxyzàèìòùáéíóúýâêîôûãñõäëïöüÿåæœçðø'" />
	<xsl:param name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZÀÈÌÒÙÁÉÍÓÚÝÂÊÎÔÛÃÑÕÄËÏÖÜŸÅÆŒÇÐØ'" />
	
	<xsl:template name="uppercase">
		<xsl:param name="value" />
		<xsl:value-of select="translate($value, $smallcase, $uppercase)" />
	</xsl:template>
	
	<xsl:template name="lowercase">
		<xsl:param name="value" />
		<xsl:value-of select="translate($value, $uppercase, $smallcase)" />
	</xsl:template>
	
	<xsl:template name="ucfirst">
		<xsl:param name="value" />
		<xsl:call-template name="uppercase">
			<xsl:with-param name="value" select="substring($value, 1, 1)" />
		</xsl:call-template>
		<xsl:call-template name="lowercase">
			<xsl:with-param name="value" select="substring($value, 2)" />
		</xsl:call-template>		
	</xsl:template>
</xsl:stylesheet>