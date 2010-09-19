<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:cw="http://www.natpryce.com/courseware/1.0">
  
  <xsl:output method="text"/>
  
  <xsl:param name="baseDir"/>
  <xsl:variable name="nl" select="'&#10;'"/>
  
  <xsl:template match="cw:dependencies">
    <xsl:value-of select="concat('base dir = ',$baseDir,$nl)"/>
    <xsl:apply-templates/>
  </xsl:template>
  
  <xsl:template match="cw:dependency">
    <xsl:value-of select="concat('&quot;', substring-after(@target,concat($baseDir,'/')),
			         '&quot;: &quot;',
				 substring-after(@dependency,concat($baseDir,'/')),
				 '&quot;',
				 $nl)"/>
  </xsl:template>
  
  <xsl:template match="text()"/>
</xsl:stylesheet>

