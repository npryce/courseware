<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:fn="http://www.w3.org/2005/xpath-functions"
		xmlns:cw="http://www.natpryce.com/courseware/1.0">
  
  <xsl:function name="cw:basename">
    <xsl:param name="path"/>
    
    <xsl:variable name="parts" select="tokenize($path,'/')"/>
    <xsl:variable name="last" select="$parts[count($parts)]"/>
    <xsl:choose>
      <xsl:when test="contains($last,'.')">
	<xsl:value-of select="substring-before($last,'.')"/>
      </xsl:when>
      <xsl:otherwise>
	<xsl:value-of select="$last"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:function>
  
  <xsl:function name="cw:dirname">
    <xsl:param name="path"/>
    
    <xsl:variable name="parts" select="tokenize($path,'/')"/>
    <xsl:value-of select="string-join(remove($parts,fn:count($parts)), '/')"/>
  </xsl:function>
  
  <xsl:function name="cw:path-of-uri">
    <xsl:param name="uri"/>
    
    <xsl:value-of select="substring-after($uri,'file:')"/>
  </xsl:function>
  
  <xsl:function name="cw:ext">
    <xsl:param name="path"/>
    
    <xsl:variable name="parts" select="tokenize($path,'/')"/>
    <xsl:variable name="last" select="$parts[count($parts)]"/>
    
    <xsl:choose>
      <xsl:when test="contains($last,'.')">
	<xsl:value-of select="substring-after($last, '.')"/>
      </xsl:when>
      <xsl:otherwise>
	<xsl:value-of select="''"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:function>
</xsl:stylesheet>
