<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:fo="http://www.w3.org/1999/XSL/Format">
  
  <xsl:output method="xml" indent="yes" />
  
  <xsl:param name="timestamp"/>
  <xsl:param name="build"/>
  <xsl:param name="courseCode"/>
  <xsl:param name="version"/>
  <xsl:param name="format"/>
  
  <xsl:include href="page-layouts.xsl" />
  <xsl:include href="create-contents.xsl" />
  <xsl:include href="../common/include-docbook-related-stylesheets.xsl" />
  <xsl:include href="../common/match-all-remaining-elements.xsl" />
  
  <xsl:variable name="copyright">
    <xsl:call-template name="docbook-copyright">
      <xsl:with-param name="docBookCopyright"
		      select="article/articleinfo/copyright" />
    </xsl:call-template>
  </xsl:variable>
  
  <xsl:template match="article">
    <fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format">
      <xsl:call-template name="create-page-layouts"/>
      
      <!-- No front matter -->
      
      <xsl:call-template name="create-contents">
	<xsl:with-param name="startingPageNumber" select="1"/>
      </xsl:call-template>
    </fo:root>
  </xsl:template>
  
  <xsl:template match="articleinfo">    
    <fo:block font-size="20pt" font-weight="bold" text-align="center">
      <xsl:value-of select="title"/>
    </fo:block>
    
    <fo:block space-before="8pt">
      <xsl:for-each select="author">
	<xsl:call-template name="docbook-author">
	  <xsl:with-param name="docbookAuthor" select="."/>
	</xsl:call-template>
      </xsl:for-each>
    </fo:block>
  </xsl:template>
  
  <!-- build-toc should do nothing -->
  <xsl:template name="build-toc" />
</xsl:stylesheet>
