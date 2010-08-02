<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:fn="http://www.w3.org/2005/xpath-functions">
  
  <xsl:output method="text"/>
  
  <xsl:template match="presentation[@fileref]">
    <xsl:apply-templates select="fn:document(fn:resolve-uri(@fileref, fn:base-uri()))"/>
  </xsl:template>
  
  <xsl:template match="visual">
    <xsl:value-of select="fn:resolve-uri(@fileref, fn:base-uri())"/>
    <xsl:value-of select="'&#10;'"/>
  </xsl:template>

  <xsl:template match="*">
    <xsl:apply-templates/>
  </xsl:template>
  
  <xsl:template match="text()"/>
</xsl:stylesheet>
