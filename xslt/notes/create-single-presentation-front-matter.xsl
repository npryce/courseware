<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:fn="http://www.w3.org/2005/xpath-functions"
		xmlns:fo="http://www.w3.org/1999/XSL/Format">
  
  <xsl:template name="create-front-matter">
    <fo:page-sequence master-reference="title">
      <fo:static-content flow-name="title-after">
	<fo:block font-size="12pt" 
		  space-after="3pt">
	  Course code: <xsl:value-of select="$courseCode" />
	</fo:block>
	<fo:block font-size="10pt"
		  space-after="3pt">
	  <xsl:value-of select="$format" /> notes
	</fo:block>
	<fo:block font-size="10pt">
	  Version: <xsl:value-of select="$version" />
	</fo:block>
	<fo:block font-size="10pt">
	  Build:  <xsl:value-of select="$build" />
	</fo:block>
	<fo:block font-size="10pt">
	  Built at:
	  <xsl:value-of select="$timestamp" />
	</fo:block>
      </fo:static-content>
      
      <fo:flow flow-name="xsl-region-body">
	<fo:block font-size="24pt" 
		  space-before="18pt"
		  space-after="18pt" 
		  text-align="center">
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