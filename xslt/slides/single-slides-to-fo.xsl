<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format">
	<xsl:output method="xml" indent="no"/>
	<xsl:param name="timestamp"/>
	<xsl:param name="build"/>
	<xsl:param name="courseCode"/>
	<xsl:param name="version"/>
	<xsl:param name="format"/>
	<xsl:param name="slideTitles"/>
	<xsl:include href="create-slide-layout.xsl"/>
	<xsl:include href="create-bookmarks-for-slides.xsl"/>
	<xsl:include href="create-slide-contents.xsl"/>
	<xsl:include href="format-slide.xsl"/>
	<xsl:include href="../common/include-docbook-related-stylesheets.xsl"/>
	<xsl:include href="../common/match-all-remaining-elements.xsl"/>
	<xsl:variable name="copyright">
		<xsl:call-template name="docbook-copyright">
			<xsl:with-param name="docBookCopyright" select="course/copyright"/>
		</xsl:call-template>
	</xsl:variable>
	
	<xsl:template match="/presentation">
		<fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format">
			<xsl:call-template name="create-slide-layout"/>
			<xsl:call-template name="create-bookmarks"/>
			<xsl:call-template name="create-slide-contents"/>
		</fo:root>
	</xsl:template>
</xsl:stylesheet>
