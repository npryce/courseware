<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:fo="http://www.w3.org/1999/XSL/Format">
	<xsl:output method="xml" indent="yes" />
	<xsl:param name="timestamp" />
	<xsl:param name="build" />
	<xsl:param name="courseCode" />
	<xsl:param name="version" />
	<xsl:param name="format" />
	<xsl:include href="page-layouts.xsl" />
	<xsl:include href="create-contents.xsl" />
	<xsl:include href="docbook-author.xsl" />
	<xsl:include href="docbook-copyright.xsl" />
	<xsl:include href="docbook-cals-table.xsl" />
	<xsl:include href="docbook-procedure.xsl" />
	<xsl:include href="test-lists.xsl" />
	<xsl:include href="docbook-text.xsl" />
	<xsl:include href="docbook-visuals.xsl" />
	<xsl:include href="docbook-section.xsl" />
	<xsl:variable name="copyright">
		<xsl:call-template name="docbook-copyright">
			<xsl:with-param name="docBookCopyright"
				select="course/copyright" />
		</xsl:call-template>
	</xsl:variable>

	<xsl:template match="course">
		<fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format">
			<xsl:include href="match-all-remaining-elements.xsl" />
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
		<fo:block id="{generate-id()}" font-size="24pt"
			font-weight="bold" break-before="page" space-before="6em"
			space-before.conditionality="retain">
			<xsl:value-of
				select='concat("Unit ",1 + count(preceding-sibling::unit), " - ",title)' />
			<xsl:for-each select="exercise|presentation">
				<fo:block start-indent="2em" font-size="20pt"
					space-before="1em" space-before.conditionality="retain"
					font-weight="normal" font-style="italic">
					<xsl:value-of
						select='concat(position(), ". ",document(@fileref)/*/title)' />
				</fo:block>
			</xsl:for-each>
		</fo:block>
		<fo:block>
			<xsl:for-each select="exercise|presentation">
				<xsl:apply-templates select="document(@fileref)" />
			</xsl:for-each>
		</fo:block>
	</xsl:template>
	<xsl:template match="include">
		<xsl:apply-templates select="document(@fileref)" />
	</xsl:template>
	<!-- copyright and author elements are pulled elsewhere, so ignore them -->
	<xsl:template match="copyright" />
	<xsl:template match="author" />
	<xsl:template match="article" />
	<xsl:template match="exercise">
         <xsl:apply-templates select="document(@fileref)"/>
	</xsl:template>
	<xsl:template match="slide">
		<fo:block break-before="page">
			<fo:block font-size="24pt">
				<xsl:value-of select="title" />
			</fo:block>
			<fo:block text-align-last="justify" font-size="1pt" space-after="14pt">
				<fo:leader leader-pattern="rule" rule-thickness="2pt" />
			</fo:block>
			<fo:block>
				<xsl:if
					test="visual and (string-length(visual/@fileref) > 0)">
					<fo:block text-align="center">
						<fo:external-graphic height="120mm"
							content-height="120mm" src="url({visual/@fileref})" />
					</fo:block>
				</xsl:if>
				<xsl:if test="vml">
					<fo:block-container height="120mm">
						<fo:block space-before="1em"
							font-size="14pt">
							<xsl:apply-templates select="vml" />
						</fo:block>
					</fo:block-container>
				</xsl:if>
			</fo:block>
			<fo:block>
				<fo:block text-align-last="justify" font-size="1pt">
					<fo:leader leader-pattern="rule"
						rule-thickness="0.1pt" />
				</fo:block>
				<xsl:apply-templates select="notes" />
			</fo:block>
		</fo:block>
	</xsl:template>
	<xsl:template match="vml">
		<xsl:apply-templates />
	</xsl:template>
	<xsl:template match="notes">
		<fo:block font-size="14pt">
			<xsl:apply-templates select="student" />
			<xsl:if test="$format = 'Presenter'">
				<xsl:apply-templates select="presenter" />
			</xsl:if>
		</fo:block>
	</xsl:template>
	<xsl:template match="student">
		<fo:block font-size="14pt" font-style="italic"
			space-before="10pt">
			Notes:
		</fo:block>
		<xsl:apply-templates select="*" />
	</xsl:template>
	<xsl:template match="presenter">
		<fo:block break-before="page">
			<fo:block space-before="10pt">Instructor notes:</fo:block>
			<fo:block text-align-last="justify" font-size="1pt">
				<fo:leader leader-pattern="rule" rule-thickness="2pt" />
			</fo:block>
			<fo:block font-size="12pt">
				<xsl:apply-templates />
			</fo:block>
		</fo:block>
	</xsl:template>
	<xsl:template name="create-bookmarks">
		<fo:bookmark-tree>
			<xsl:for-each select="unit">
				<fo:bookmark internal-destination="{generate-id()}">
					<fo:bookmark-title>
						<xsl:value-of select="title" />
					</fo:bookmark-title>
					<xsl:for-each
						select="exercise|presentation|handout">
						<xsl:variable name="topic"
							select="document(@fileref)" />
						<xsl:for-each select="$topic/*">
							<fo:bookmark
								internal-destination="{generate-id()}">
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
	<xsl:template name="create-front-matter">
		<fo:page-sequence master-reference="title">
			<fo:static-content flow-name="title-after">
				<fo:block font-size="12pt" text-align="right">
					Version:
					<xsl:value-of select="$version" />
				</fo:block>
				<fo:block font-size="12pt" text-align="right">
					<xsl:value-of select="$format" />
					notes
				</fo:block>
				<fo:block font-size="10pt" font-style="italic"
					text-align="right">
					Course code:
					<xsl:value-of select="$courseCode" />
				</fo:block>
			</fo:static-content>
			<fo:flow flow-name="xsl-region-body">
				<fo:block font-size="20pt" space-before="18pt"
					space-after="3pt" text-align="center">
					<xsl:value-of select="title" />
				</fo:block>
				<fo:block font-size="16pt" space-before="3em">
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
				<fo:block font-size="10pt" text-align="right">
					Build:
					<xsl:value-of select="$build" />
				</fo:block>
				<fo:block font-size="10pt" text-align="right">
					Built at:
					<xsl:value-of select="$timestamp" />
				</fo:block>
				<fo:block font-size="10pt" font-style="italic"
					text-align="right">
					Course code:
					<xsl:value-of select="$courseCode" />
				</fo:block>
			</fo:static-content>
			<fo:flow flow-name="xsl-region-body">
				<fo:block font-size="18pt" space-before="18pt"
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
	<xsl:template name="build-toc">
		<fo:block>
			<fo:block font-weight="bold" font-size="20pt"
				space-after="20pt">
				Contents:
			</fo:block>
			<xsl:for-each select="unit">
				<fo:block text-align-last="justify">
					<fo:inline>
						<xsl:value-of select="title" />
						<fo:leader leader-pattern="dots" />
						<fo:basic-link
							internal-destination="{generate-id()}">
							<fo:page-number-citation color="blue"
								ref-id="{generate-id()}" />
						</fo:basic-link>
					</fo:inline>
				</fo:block>
			</xsl:for-each>
		</fo:block>
	</xsl:template>
</xsl:stylesheet>
