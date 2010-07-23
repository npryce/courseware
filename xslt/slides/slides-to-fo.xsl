<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format">
	<xsl:output method="xml" indent="yes"/>
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
	<xsl:template match="course">
		<fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format">
			<xsl:call-template name="create-slide-layout"/>
			<xsl:call-template name="create-bookmarks"/>
			<xsl:call-template name="create-slide-contents">
				
			</xsl:call-template>
		</fo:root>
	</xsl:template>
	<xsl:template match="unit">
		<fo:block id="{generate-id()}" font-size="36pt" break-before="page" start-indent="4em" space-before="72pt" space-before.conditionality="retain">
			<fo:block>
				<xsl:value-of select='concat("Unit ",1 + count(preceding-sibling::unit), " - ")'/>
				<fo:inline font-weight="bold">
					<xsl:value-of select="title"/>
				</fo:inline>
			</fo:block>
			<fo:block space-before="2em" font-size="28pt">
				<fo:list-block start-indent="6em">
					<xsl:for-each select="exercise|presentation">
						<fo:list-item>
							<fo:list-item-label end-indent="label-end()">
								<fo:block>&#x2022;</fo:block>
							</fo:list-item-label>
							<fo:list-item-body start-indent="body-start()" wrap-option="wrap" end-indent="1em">
								<fo:block>
									<xsl:value-of select="document(@fileref)/*/title"/>
								</fo:block>
							</fo:list-item-body>
						</fo:list-item>
					</xsl:for-each>
				</fo:list-block>
			</fo:block>
		</fo:block>
		<fo:block>
			<xsl:for-each select="exercise|presentation">
				<xsl:apply-templates select="document(@fileref)"/>
			</xsl:for-each>
		</fo:block>
	</xsl:template>
	<xsl:template match="include">
		<xsl:apply-templates select="document(@fileref)"/>
	</xsl:template>
	<xsl:template match="section|presentation">
	  <xsl:apply-templates />
	</xsl:template>
	<!-- copyright and author elements are pulled elsewhere, so ignore them -->
	<xsl:template match="copyright"/>
	<xsl:template match="author"/>
	<xsl:template match="article"/>
	<xsl:template match="exercise"/>
	<xsl:template match="notes"/>
</xsl:stylesheet>
