<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" 
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
		xmlns:fo="http://www.w3.org/1999/XSL/Format">
  <xsl:param name="timestamp" />
  <xsl:param name="build" />
  <xsl:param name="courseCode" />
  <xsl:param name="version" />
  <xsl:param name="format" />
  
  <xsl:include href="page-layouts.xsl" />
  <xsl:include href="create-front-matter.xsl" />
  <xsl:include href="build-toc.xsl" />
  <xsl:include href="create-bookmarks-for-notes.xsl" />
  <xsl:include href="create-contents.xsl" />
  <xsl:include href="format-notes.xsl" />
  <xsl:include href="format-slide-for-notes.xsl" />
  <xsl:include href="../common/include-docbook-related-stylesheets.xsl" />
  <xsl:include href="../common/match-all-remaining-elements.xsl" />
  
  <xsl:variable name="copyright">
    <xsl:call-template name="docbook-copyright">
      <xsl:with-param name="docBookCopyright"
		      select="/copyright" />
    </xsl:call-template>
  </xsl:variable>
  
  <xsl:template match="/presentation">
    <fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format">
      <xsl:call-template name="create-page-layouts" />
      <xsl:call-template name="create-bookmarks" />
      <xsl:call-template name="create-front-matter" />
      <!-- Two pages in front matter -->
      <xsl:call-template name="create-contents">
	<xsl:with-param name="startingPageNumber" select="3" />
      </xsl:call-template>
    </fo:root>
  </xsl:template>
</xsl:stylesheet>
