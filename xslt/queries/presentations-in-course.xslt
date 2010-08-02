<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:fo="http://www.w3.org/1999/XSL/Format">
  
  <xsl:output method="text"/>
  
  <xsl:template match="presentation[@fileref]">
    <xsl:value-of select="resolve-uri(@fileref, base-uri())"/>
    <xsl:value-of select="'&#10;'"/>
  </xsl:template>
  
  <xsl:template match="*">
    <xsl:apply-templates/>
  </xsl:template>
  
  <xsl:template match="text()"/>
</xsl:stylesheet>
