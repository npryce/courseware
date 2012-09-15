<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fn="http://www.w3.org/2005/xpath-functions"
                xmlns:fo="http://www.w3.org/1999/XSL/Format">

    <xsl:template name="build-toc">
        <fo:block>
            <fo:block font-weight="bold"
                      font-size="20pt"
                      space-after="20pt">
                Contents:
            </fo:block>
            <xsl:for-each select="unit">
                <fo:block text-align-last="justify">
                    <fo:inline>
                        <xsl:value-of select="title"/>
                        <fo:leader leader-pattern="dots"/>
                        <fo:basic-link
                                internal-destination="{fn:generate-id()}">
                            <fo:page-number-citation color="blue"
                                                     ref-id="{fn:generate-id()}"/>
                        </fo:basic-link>
                    </fo:inline>
                </fo:block>
            </xsl:for-each>
        </fo:block>
    </xsl:template>
</xsl:stylesheet>