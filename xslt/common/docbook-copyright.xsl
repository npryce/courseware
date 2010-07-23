<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:fo="http://www.w3.org/1999/XSL/Format"
		xmlns:fox="http://xml.apache.org/fop/extensions">
  
  <xsl:template name="docbook-copyright">
    <xsl:param name="docBookCopyright" />
    
    <xsl:value-of select="'Copyright &#x00a9; '" />
    <xsl:for-each select="$docBookCopyright/year">
      <xsl:value-of select="." />
      <xsl:if test="position() != last()">,</xsl:if>
    </xsl:for-each>
    <xsl:value-of select="' '" />
    <xsl:for-each select="$docBookCopyright/holder">
      <xsl:value-of select="." />
      <xsl:if test="position() != last()">,</xsl:if>
    </xsl:for-each>
  </xsl:template>
</xsl:stylesheet>
