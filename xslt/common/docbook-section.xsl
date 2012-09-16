<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fn="http://www.w3.org/2005/xpath-functions"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                xmlns:fox="http://xml.apache.org/fop/extensions">

    <xsl:template match="section|presentation">
        <!-- depth will be zero if we're a presentation or top-level section -->
        <xsl:variable name="depth" select="count(ancestor::section|ancestor::article)"/>

        <fo:block id="{fn:generate-id()}">
            <xsl:if test="$depth = 0">
                <xsl:attribute name="break-before">page</xsl:attribute>
                <xsl:attribute name="space-before">24pt</xsl:attribute>
                <xsl:attribute name="space-before.conditionality">retain</xsl:attribute>
            </xsl:if>

            <fo:block font-weight="bold"
                      space-before="1em"
                      keep-with-next="always">
                <xsl:attribute name="font-size">
                    <xsl:choose>
                        <xsl:when test="$depth  = 0">24</xsl:when>
                        <xsl:when test="$depth  = 1">18</xsl:when>
                        <xsl:when test="$depth  = 2">16</xsl:when>
                        <xsl:otherwise>14</xsl:otherwise>
                    </xsl:choose>
                </xsl:attribute>
                <xsl:value-of select="title"/>
                <fo:block font-size="16" space-after="1em">
                    <xsl:value-of select="subtitle"/>
                </fo:block>
            </fo:block>

            <xsl:apply-templates/>
            <!-- If there are visuals with copyright info, display the holder, year and license
                with a link back to the visual.
                The id of the visual is set in  the slide template in 'format-slide-for-notes.xsl' -->
            <xsl:if test="fn:count(slide/visual/copyright) &gt; 0">
                <fo:block break-before="page" space-before="24pt" font-size="16">
                    <xsl:value-of select="'Image Credits'"/>
                    <fo:block space-before="16pt" font-size="14">
                        <xsl:for-each select="slide">
                            <xsl:if test="visual/copyright">
                                <fo:inline>
                                    <xsl:value-of select="visual/copyright/holder"/>
                                    <xsl:value-of select="' (c) '"/>
                                    <xsl:value-of select="visual/copyright/year"/>
                                    <fo:leader leader-pattern="dots"/>
                                <fo:basic-link internal-destination="{fn:generate-id()}">
                               	      <fo:page-number-citation color="blue"
                               				       ref-id="{fn:generate-id()}" />
                               	</fo:basic-link>
                                </fo:inline>
                            </xsl:if>
                            <xsl:if test="visual/license">
                                <fo:block space-before="3pt"/>
                                <fo:inline font-size="12" font-style="italic">
                                    <xsl:value-of select="'license: '"/>
                                    <xsl:value-of select="visual/license"/>
                                </fo:inline>
                                <fo:block space-after="12pt"/>
                            </xsl:if>
                        </xsl:for-each>
                    </fo:block>
                </fo:block>
            </xsl:if>
        </fo:block>
    </xsl:template>

    <!-- Titles and subtitles are pulled by the styling for their parent, so ignore them -->
    <xsl:template match="title|subtitle"/>
</xsl:stylesheet>