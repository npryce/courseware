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
		      select="course/copyright" />
    </xsl:call-template>
  </xsl:variable>
  
  <xsl:template match="course">
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
  
  <xsl:template match="unit">
    <fo:block id="{fn:generate-id()}" 
	      font-size="24pt"
	      break-before="page" 
	      space-before="72pt"
	      space-before.conditionality="retain">
      <fo:block>
	<xsl:value-of
	    select='fn:concat("Unit ",1 + fn:count(preceding-sibling::unit))' />
      </fo:block>
      
      <fo:block font-weight="bold" space-before="1em">
	<xsl:value-of select="title"/>
      </fo:block>
      
      <xsl:for-each select="exercise|presentation">
	<fo:block start-indent="2em" 
		  font-size="20pt"
		  space-before="1em" 
		  space-before.conditionality="retain"
		  font-weight="normal">
	  <xsl:value-of
	      select='fn:concat(fn:position(), ". ",fn:document(@fileref,.)/*/title)' />
	</fo:block>
      </xsl:for-each>
    </fo:block>
    
    <fo:block>
      <xsl:for-each select="exercise|presentation">
	<xsl:apply-templates select="document(@fileref,.)" />
      </xsl:for-each>
    </fo:block>
  </xsl:template>
  
  <!-- copyright and author elements are pulled elsewhere, so ignore them -->
  <xsl:template match="copyright" />
  <xsl:template match="author" />
  <xsl:template match="article" />
  
  <xsl:template match="exercise">
    <xsl:apply-templates select="document(@fileref,.)/article/section"/>
  </xsl:template>
</xsl:stylesheet>
