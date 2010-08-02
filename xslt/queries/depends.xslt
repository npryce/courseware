<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:fn="http://www.w3.org/2005/xpath-functions"
		xmlns:cw="http://www.natpryce.com/courseware/1.0">
  
  <xsl:output method="text"/>
  
  <xsl:param name="outputDir"/>
  <xsl:param name="courseDir" select="cw:dirname(fn:base-uri())"/>
  <xsl:param name="courseCode" select="cw:basename(fn:base-uri())"/>
  
  <xsl:variable name="student-notes-fo"><xsl:value-of 
    select="$outputDir"/>/fo/<xsl:value-of 
    select="$courseDir"/>/<xsl:value-of 
    select="$courseCode"/>-student-notes.fo</xsl:variable>
  
  <xsl:variable name="student-notes-pdf"><xsl:value-of 
    select="$outputDir"/>/pdf/<xsl:value-of 
    select="$courseDir"/>/<xsl:value-of 
    select="$courseCode"/>-student-notes.pdf</xsl:variable>
  
  <xsl:variable name="presenter-notes-fo"><xsl:value-of 
    select="$outputDir"/>/fo/<xsl:value-of 
    select="$courseDir"/>/<xsl:value-of 
    select="$courseCode"/>-presenter-notes.fo</xsl:variable>
  
  <xsl:variable name="presenter-notes-pdf"><xsl:value-of 
    select="$outputDir"/>/pdf/<xsl:value-of 
    select="$courseDir"/>/<xsl:value-of 
    select="$courseCode"/>-presenter-notes.pdf</xsl:variable>
  
  <xsl:template match="presentation[@fileref]">
    <xsl:variable name="presentation" select="fn:resolve-uri(@fileref, fn:base-uri())"/>
    <xsl:variable name="presentation-code" select="cw:basename(@fileref)"/>
    
    <xsl:call-template name="depends">
      <xsl:with-param name="target" select="$student-notes-fo"/>
      <xsl:with-param name="dependency" select="$presentation"/>
    </xsl:call-template>
    
    <xsl:call-template name="depends">
      <xsl:with-param name="target" select="$presenter-notes-fo"/>
      <xsl:with-param name="dependency" select="$presentation"/>
    </xsl:call-template>
    
    <xsl:apply-templates select="fn:document($presentation)"/>
  </xsl:template>
  
  <xsl:template match="visual[@fileref]">
    <xsl:variable name="visual" select="fn:resolve-uri(@fileref, fn:base-uri())"/>
    
    <xsl:call-template name="depends">
      <xsl:with-param name="target" select="$student-notes-pdf"/>
      <xsl:with-param name="dependency" select="$visual"/>
    </xsl:call-template>
    
    <xsl:call-template name="depends">
      <xsl:with-param name="target" select="$presenter-notes-pdf"/>
      <xsl:with-param name="dependency" select="$visual"/>
    </xsl:call-template>
  </xsl:template>
  
  <xsl:template match="*">
    <xsl:apply-templates/>
  </xsl:template>
  
  <xsl:template match="text()"/>
  
  <xsl:template name="depends">
    <xsl:param name="target"/>
    <xsl:param name="dependency"/>
    
    <xsl:value-of select="$target"/>
    <xsl:value-of select="': '"/>
    <xsl:value-of select="substring($dependency,6)"/>
    <xsl:value-of select="'&#10;'"/>
  </xsl:template>
  
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
      <xsl:when test="fn:starts-with($uri,'file:/')">
	<xsl:value-of select="cw:dirname(fn:substring-after($uri,'file:'))"/>
      </xsl:when>
      <xsl:when test="fn:contains($uri,'/')">
	<xsl:value-of select="fn:concat(fn:substring-before($uri,'/'),'/', cw:dirname(fn:substring-after($uri, '/')))"/>
      </xsl:when>
      <xsl:otherwise>
	<xsl:value-of select="$uri"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:function>
</xsl:stylesheet>
