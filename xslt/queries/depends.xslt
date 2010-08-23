<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:cw="http://www.natpryce.com/courseware/1.0">
  
  <xsl:import href="functions.xslt"/>
  
  <xsl:output method="xml" indent="yes"/>
  
  <xsl:param name="outputDir"/>
  <xsl:param name="courseDir"/>
  
  <xsl:variable name="course"
		select="substring-before(
			    substring-after(
			        base-uri(), 
			        resolve-uri(concat($courseDir, '/'), base-uri())),
			    '.course')"/>
  
  <xsl:function name="cw:target">
    <xsl:param name="name"/>
    <xsl:variable name="format" select="substring-after($name, '.')"/>
    
    <xsl:value-of select="concat($outputDir,'/',$format,'/',$course,'-',$name)"/>
  </xsl:function>
  
  <xsl:template match="course">
    <cw:dependencies>
      <xsl:apply-templates/>
    </cw:dependencies>
  </xsl:template>
  
  <xsl:template match="presentation[@fileref]|exercise[@fileref]">
    <xsl:variable name="presentation" select="resolve-uri(@fileref, base-uri())"/>
    <xsl:variable name="path" select="cw:path-of-uri($presentation)"/>
    
    <cw:dependency target="{cw:target('student-notes.fo')}" dependency="{$path}"/>
    <cw:dependency target="{cw:target('presenter-notes.fo')}" dependency="{$path}"/>
    <cw:dependency target="{cw:target('slides.fo')}" dependency="{$path}"/>
    
    <xsl:apply-templates select="document($presentation)"/>
  </xsl:template>
  
  <xsl:template match="visual[@fileref]">
    <xsl:variable name="visual" select="resolve-uri(@fileref, base-uri())"/>
    <xsl:variable name="path" select="cw:path-of-uri($visual)"/>
    
    <cw:dependency target="{cw:target('student-notes.pdf')}" dependency="{$path}"/>
    <cw:dependency target="{cw:target('presenter-notes.pdf')}" dependency="{$path}"/>
    <cw:dependency target="{cw:target('slides.pdf')}" dependency="{$path}"/>
  </xsl:template>
  
  <xsl:template match="*">
    <xsl:apply-templates/>
  </xsl:template>
  
  <xsl:template match="text()"/>
</xsl:stylesheet>
