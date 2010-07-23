<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:fn="http://www.w3.org/2005/xpath-functions"
		xmlns:fo="http://www.w3.org/1999/XSL/Format">
  
  <xsl:template name="create-front-matter">
    <fo:page-sequence master-reference="title">
      <fo:static-content flow-name="title-after">
	<fo:block font-size="12pt" 
		  text-align="right">
	  Version:
	  <xsl:value-of select="$version" />
	</fo:block>
	<fo:block font-size="12pt" 
		  text-align="right">
	  <xsl:value-of select="$format" />
	  notes
	</fo:block>
	<fo:block font-size="10pt" 
		  font-style="italic"
		  text-align="right">
	  Course code:
	  <xsl:value-of select="$courseCode" />
	</fo:block>
      </fo:static-content>
      <fo:flow flow-name="xsl-region-body">
	<fo:block font-size="20pt" 
		  space-before="18pt"
		  space-after="3pt" 
		  text-align="center">
	  <xsl:value-of select="title" />
	</fo:block>
	<fo:block font-size="16pt" 
		  space-before="3em">
	  <xsl:for-each select="/course/author">
	    <xsl:call-template name="docbook-author">
	      <xsl:with-param name="docbookAuthor" select="." /> 
	    </xsl:call-template>
	  </xsl:for-each>
	  
	</fo:block>
      </fo:flow>
    </fo:page-sequence>
    <fo:page-sequence master-reference="frontispiece">
      <fo:static-content flow-name="frontispiece-after">
	<fo:block font-size="10pt" 
		  text-align="right">
	  Build:
	  <xsl:value-of select="$build" />
	</fo:block>
	<fo:block font-size="10pt" 
		  text-align="right">
	  Built at:
	  <xsl:value-of select="$timestamp" />
	</fo:block>
	<fo:block font-size="10pt" 
		  font-style="italic"
		  text-align="right">
	  Course code:
	  <xsl:value-of select="$courseCode" />
	</fo:block>
      </fo:static-content>
      <fo:flow flow-name="xsl-region-body">
	<fo:block font-size="18pt" 
		  space-before="18pt"
		  space-after="3pt">
	  <xsl:value-of select="title" />
	</fo:block>
	<fo:block>
	  <xsl:value-of select="$copyright" />
	</fo:block>
	<fo:block color="red" font-weight="bold"
		  space-before="20pt">
	  Course materials may not be copied or distributed in
	  any form without the prior written permission of the
	  copyright holders.
	</fo:block>
      </fo:flow>
    </fo:page-sequence>
  </xsl:template>
</xsl:stylesheet>