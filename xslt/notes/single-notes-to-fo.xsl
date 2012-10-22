<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" 
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
		xmlns:fn="http://www.w3.org/2005/xpath-functions"
		xmlns:fo="http://www.w3.org/1999/XSL/Format">
  
  <xsl:param name="timestamp" />
  <xsl:param name="build" />
  <xsl:param name="courseCode" />
  <xsl:param name="version" />
  <xsl:param name="format" />
  
  <xsl:include href="page-layouts.xsl" />
  <xsl:include href="create-bookmarks-for-notes.xsl" />
  <xsl:include href="format-notes.xsl" />
  <xsl:include href="format-slide-for-notes.xsl" />
  <xsl:include href="create-single-presentation-front-matter.xsl" />
  <xsl:include href="../common/include-docbook-related-stylesheets.xsl" />
  <xsl:include href="../common/match-all-remaining-elements.xsl" />
  
  <xsl:variable name="copyright">
    <xsl:call-template name="docbook-copyright">
      <xsl:with-param name="docBookCopyright"
		      select="/presentation/copyright" />
    </xsl:call-template>
  </xsl:variable>
  
  <xsl:template match="/presentation">
    <fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format">
      <xsl:call-template name="create-page-layouts" />
      <xsl:call-template name="create-bookmarks" />
      <xsl:call-template name="create-front-matter" />
      
      <fo:page-sequence master-reference="contents" initial-page-number="2">
	<fo:flow flow-name="xsl-region-body" padding="0">
	  <xsl:apply-templates />
	</fo:flow>
      </fo:page-sequence>
    </fo:root>
  </xsl:template>
  
  <xsl:template match="/presentation/copyright">
  </xsl:template>
</xsl:stylesheet>
