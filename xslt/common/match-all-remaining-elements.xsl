<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:fo="http://www.w3.org/1999/XSL/Format"
   xmlns:fox="http://xml.apache.org/fop/extensions">
   <!-- Catch-all to detect unmatched elements -->
   <xsl:template match="*">
       <xsl:variable name="msg">***************** Element <xsl:value-of select="name(..)" />/<xsl:value-of select="name(  )" /> found, with no template. ****************</xsl:variable>
      <xsl:message terminate="no">
      <xsl:value-of select="$msg"/>
      </xsl:message>
      <fo:block color="red"><xsl:value-of select="$msg"/></fo:block>
   </xsl:template>
</xsl:stylesheet>