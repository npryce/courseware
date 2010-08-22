<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:cw="http://www.natpryce.com/courseware/1.0">
  
  <xsl:output method="text"/>
  
  <xsl:template match="cw:dependencies">
    <xsl:apply-templates/>
  </xsl:template>
  
  <xsl:template match="cw:dependency">
    <xsl:value-of select="concat(@target,': ',@dependency,'&#10;')"/>
  </xsl:template>
  
  <xsl:template match="text()"/>
</xsl:stylesheet>

