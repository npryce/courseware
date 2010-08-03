<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:fn="http://www.w3.org/2005/xpath-functions"
		xmlns:cw="http://www.natpryce.com/courseware/1.0">
  
  <xsl:import href="functions.xslt"/>
  
  <xsl:output method="xml" indent="yes"/>
  
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
  
  
  <xsl:template match="/">
    <cw:dependencies>
      <xsl:apply-templates select="course"/>
    </cw:dependencies>
  </xsl:template>
  
  <xsl:template match="presentation[@fileref]|exercise[@fileref]">
    <xsl:variable name="presentation" select="fn:resolve-uri(@fileref, fn:base-uri())"/>
    <xsl:variable name="presentation-code" select="cw:basename(@fileref)"/>
    
    <cw:dependency target="{$student-notes-fo}" dependency="{$presentation}"/>
    <cw:dependency target="{$presenter-notes-fo}" dependency="{$presentation}"/>
    
    <xsl:apply-templates select="fn:document($presentation)"/>
  </xsl:template>
  
  <xsl:template match="visual[@fileref]">
    <xsl:variable name="visual" select="fn:resolve-uri(@fileref, fn:base-uri())"/>
    
    <cw:dependency target="{$student-notes-pdf}" dependency="{$visual}"/>
    <cw:dependency target="{presenter-notes-pdf}" dependency="{$visual}"/>
  </xsl:template>
  
  <xsl:template match="*">
    <xsl:apply-templates/>
  </xsl:template>
  
  <xsl:template match="text()"/>
</xsl:stylesheet>
