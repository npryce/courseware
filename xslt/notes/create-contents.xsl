<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:fo="http://www.w3.org/1999/XSL/Format"
		xmlns:fox="http://xml.apache.org/fop/extensions">

  <xsl:template name="create-contents">
    <xsl:param name="startingPageNumber" />
    
    <fo:page-sequence master-reference="contents"
		      initial-page-number="{$startingPageNumber}">
      
      <fo:static-content flow-name="contents-even-after">
	<fo:block text-align-last="justify">
	  <fo:leader leader-pattern="rule"
		     rule-thickness="0.1pt" />
	</fo:block>
	
	<fo:block font-size="8pt" text-align-last="justify"
		  start-indent="10pt" end-indent="10pt">
	  <xsl:value-of select="$copyright" />
	  <fo:leader leader-pattern="space" />
	  Page
	  <fo:page-number />
	</fo:block>
      </fo:static-content>
      
      <fo:static-content flow-name="contents-odd-after">
	<fo:block text-align-last="justify">
	  <fo:leader leader-pattern="rule"
		     rule-thickness="0.1pt" />
	</fo:block>
	
	<fo:block font-size="8pt" text-align-last="justify"
		  start-indent="10pt" end-indent="10pt">
	  Page
	  <fo:page-number />
	  <fo:leader leader-pattern="space" />
	  <xsl:value-of select="$copyright" />
	</fo:block>
      </fo:static-content>
      
      <fo:flow flow-name="xsl-region-body" padding="0">
	<xsl:call-template name="build-toc" />
	<xsl:apply-templates />
      </fo:flow>
    </fo:page-sequence>
  </xsl:template>
</xsl:stylesheet>