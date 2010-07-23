<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:fo="http://www.w3.org/1999/XSL/Format"
		xmlns:fox="http://xml.apache.org/fop/extensions">
  
  <xsl:template name="docbook-author">
    <xsl:param name="docbookAuthor" />
    
    <fo:block font-size="14pt" text-align="center">
      <xsl:value-of select="$docbookAuthor/personname/firstname" />
      <xsl:value-of select="' '" />
      <xsl:value-of select="$docbookAuthor/personname/surname" />
      
      <xsl:if test="$docbookAuthor/email">
	<xsl:value-of select="' - '" />
	<xsl:value-of select="$docbookAuthor/email" />
      </xsl:if>
    </fo:block>
  </xsl:template>
</xsl:stylesheet>
