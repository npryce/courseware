<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
	<xsl:template match="course">
		<map version="0.9.0_Beta_8">
			<node ID="{generate-id()}" TEXT="{title}">
				<xsl:for-each select="unit">
					<node ID="{generate-id()}" TEXT="{title}">
						<xsl:for-each select="presentation|exercise">
							<xsl:apply-templates select="document(@fileref)"/>
						</xsl:for-each>
					</node>
				</xsl:for-each>
			</node>
		</map>
	</xsl:template>
	<xsl:template match="handout">
		<xsl:apply-templates select="document(@fileref)"/>
	</xsl:template>
	<xsl:template match="presentation|exercise">
		<node ID="{generate-id()}" TEXT="{*/title}">
			<xsl:apply-templates/>
		</node>
	</xsl:template>
	<xsl:template match="article">
		<xsl:apply-templates/>
	</xsl:template>
	<xsl:template match="section">
		<node ID="{generate-id()}" TEXT="{title}">
			<xsl:apply-templates/>
		</node>
	</xsl:template>
	<xsl:template match="slide">
		<node ID="{generate-id()}" TEXT="{title}">
			<xsl:variable name="fileref" select="visual/@fileref "/>
			<xsl:if test="$fileref and string-length($fileref) != 0">
				<xsl:attribute name="LINK">../../courseware/visuals/<xsl:value-of select="$fileref"/></xsl:attribute>
			</xsl:if>
		</node>
	</xsl:template>
	<!-- handled by pull -->
	<xsl:template match="title">
	</xsl:template>
	<xsl:template match="section">
	</xsl:template>
	<xsl:template match="*">
		<xsl:variable name="msg">***************** Element <xsl:value-of select="name(..)"/>/<xsl:value-of select="name(  )"/> found, with no template. ****************</xsl:variable>
		<xsl:message terminate="no">
			<xsl:value-of select="$msg"/>
		</xsl:message>
	</xsl:template>
</xsl:stylesheet>
