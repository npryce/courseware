<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:fox="http://xml.apache.org/fop/extensions">
	<xsl:template match="itemizedlist">
		<xsl:variable name="depth" select="count(ancestor::itemizedlist)"/>
		<fo:block>
			<fo:list-block start-indent="{0.5 + ( 0.5 * $depth ) }em" provisional-distance-between-starts="{1 + ( 0.5 * $depth )}em">
				<xsl:for-each select="listitem">
					<fo:list-item>
						<fo:list-item-label end-indent="label-end()">
							<fo:block>
								<xsl:choose>
									<xsl:when test="$depth = 0">&#x2022;</xsl:when>
									<xsl:otherwise>-</xsl:otherwise>
								</xsl:choose>
							</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()" wrap-option="wrap" end-indent="1em">
							<xsl:apply-templates/>
						</fo:list-item-body>
					</fo:list-item>
				</xsl:for-each>
			</fo:list-block>
		</fo:block>
	</xsl:template>
	<xsl:template match="orderedlist">
		<xsl:variable name="depth" select="count(ancestor::orderedlist)"/>
		<fo:list-block start-indent="{1 + $depth }em" provisional-distance-between-starts="{10 + ( 5 * $depth )}mm">
			<xsl:for-each select="listitem">
				<fo:list-item>
					<fo:list-item-label end-indent="label-end()">
						<fo:block>
							<xsl:number level="multiple" count="orderedlist/listitem" format="1.1.a. "/>
						</fo:block>
					</fo:list-item-label>
					<fo:list-item-body start-indent="body-start()" end-indent="1em">
						<xsl:apply-templates/>
					</fo:list-item-body>
				</fo:list-item>
			</xsl:for-each>
		</fo:list-block>
	</xsl:template>
</xsl:stylesheet>
