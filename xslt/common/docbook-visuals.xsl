<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:fo="http://www.w3.org/1999/XSL/Format"
	xmlns:fox="http://xml.apache.org/fop/extensions">
	<xsl:template match="screenshot">
		<xsl:apply-templates select="mediaobject" />
	</xsl:template>
	<xsl:template match="mediaobject">
		<xsl:variable name="imagedata" select="imageobject/imagedata" />
		<fo:block text-align="center">
			<fo:external-graphic src="url({$imagedata/@fileref})">
				<xsl:if test="$imagedata/@width">
					<xsl:attribute name="width"><xsl:value-of
							select="$imagedata/@width" />
					</xsl:attribute>
				</xsl:if>
				<xsl:if test="$imagedata/@contentwidth">
					<xsl:attribute name="content-width"><xsl:value-of
							select="$imagedata/@contentwidth" />
					</xsl:attribute>
				</xsl:if>
			</fo:external-graphic>
		</fo:block>
	</xsl:template>
</xsl:stylesheet>