<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:fn="http://www.w3.org/2005/xpath-functions"
		xmlns:cw="http://www.natpryce.com/courseware/1.0">

  
  <xsl:function name="cw:basename">
    <xsl:param name="uri"/>
    
    <xsl:choose>
      <xsl:when test="fn:contains($uri,'/')">
	<xsl:value-of select="cw:basename(fn:substring-after($uri,'/'))"/>
      </xsl:when>
      <xsl:when test="fn:contains($uri,'.')">
	<xsl:value-of select="fn:substring-before($uri,'.')"/>
      </xsl:when>
      <xsl:otherwise>
	<xsl:value-of select="$uri"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:function>
  
  <xsl:function name="cw:dirname">
    <xsl:param name="uri"/>
    
    <xsl:choose>
      <xsl:when test="fn:contains($uri,'/')">
	<xsl:value-of select="fn:concat(fn:substring-before($uri,'/'),
			                '/', 
			                cw:dirname(fn:substring-after($uri, '/')))"/>
      </xsl:when>
      <xsl:otherwise>
	<xsl:value-of select="cw:path-of-uri($uri)"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:function>
  
  <xsl:function name="cw:path-of-uri">
    <xsl:param name="uri"/>
    
    <xsl:choose>
      <xsl:when test="fn:starts-with($uri,'file:/')">
	<xsl:value-of select="fn:substring-after($uri,'file:')"/>
      </xsl:when>
      <xsl:otherwise>
	<xsl:value-of select="$uri"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:function>
</xsl:stylesheet>
