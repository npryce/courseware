<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:fn="http://www.w3.org/2005/xpath-functions"
		xmlns:cw="http://www.natpryce.com/courseware/1.0">
  
  <xsl:import href="functions.xslt"/>
  
  <xsl:output method="text"/>
  
  <xsl:template match="cw:dependency">
    <xsl:value-of select="cw:path-of-uri(@target)"/>
    <xsl:value-of select="': '"/>
    <xsl:value-of select="cw:path-of-uri(@dependency)"/>
    <xsl:value-of select="'&#10;'"/>
    
    <xsl:apply-templates/>
  </xsl:template>
  
  <xsl:template match="cw:copy">
    <xsl:value-of select="'&#10;cp $&lt; $@'"/>
  </xsl:template>
  
  <xsl:template match="*">
    <xsl:apply-templates/>
  </xsl:template>
  
  <xsl:template match="text()"/>
</xsl:stylesheet>

