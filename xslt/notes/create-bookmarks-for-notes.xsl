<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:fn="http://www.w3.org/2005/xpath-functions"
		xmlns:fo="http://www.w3.org/1999/XSL/Format"
		xmlns:fox="http://xml.apache.org/fop/extensions">
  
  <xsl:template name="create-bookmarks">
    <fo:bookmark-tree>
      <xsl:for-each select="unit">
	<fo:bookmark internal-destination="{fn:generate-id()}">
	  <fo:bookmark-title>
	    <xsl:value-of select="title" />
	  </fo:bookmark-title>
	  <xsl:for-each
	      select="exercise|presentation|handout">
	    <xsl:variable name="topic"
			  select="fn:document(@fileref,.)" />
	    <xsl:for-each select="$topic/*">
	      <fo:bookmark
		  internal-destination="{fn:generate-id()}">
		<fo:bookmark-title>
		  <xsl:value-of select="title" />
		</fo:bookmark-title>
	      </fo:bookmark>
	    </xsl:for-each>
	  </xsl:for-each>
	</fo:bookmark>
      </xsl:for-each>
    </fo:bookmark-tree>
  </xsl:template>
</xsl:stylesheet>