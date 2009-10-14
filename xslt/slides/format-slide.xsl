<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:fox="http://xml.apache.org/fop/extensions">
  <xsl:template match="slide">
    <fo:block break-before="page">
      <!-- removed title at the request of the Doctors... RC -->
      <!--  reworked so that VML slides always have a title. Still got duplication. SF -->
      <xsl:if test="visual and (string-length(visual/@fileref) > 0)">
        <xsl:choose>
          <xsl:when test="$slideTitles = 'True'">
            <fo:block font-size="42pt" text-align="center" space-before="1em" space-before.conditionality="retain" min-height="54pt">
              <xsl:value-of select="title"/>
            </fo:block>
            <fo:block text-align="center">
              <fo:external-graphic height="640px" width="800px" content-height="scale-to-fit" content-width="scale-to-fit" src="url({visual/@fileref})"/>
            </fo:block>
          </xsl:when>
          <xsl:otherwise>
            <fo:block text-align="center">
              <xsl:attribute name="background-color">
                  <xsl:apply-templates mode="background-color" select="."/>
              </xsl:attribute>
              <fo:external-graphic height="768px" width="1024px" content-height="scale-to-fit" content-width="scale-to-fit" display-align="center" src="url({visual/@fileref})"/>
            </fo:block>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:if>
      <xsl:if test="vml">
        <fo:block font-size="42pt" text-align="center" space-before="1em" space-before.conditionality="retain" min-height="48pt">
          <xsl:value-of select="title"/>
        </fo:block>
        <fo:block-container height="640px" start-indent="64px" end-indent="64px" margin-top="32px" >
          <fo:block space-before="1em" start-indent="0px" end-indent="0px" font-size="28pt">
            <xsl:apply-templates select="vml"/>
          </fo:block>
        </fo:block-container>
      </xsl:if>
    </fo:block>
  </xsl:template>

  <xsl:template match="vml">
      <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="slide[visual[@bg]]" mode="background-color">
    <xsl:value-of select="visual/@bg"/>
  </xsl:template>
  
  <xsl:template match="slide[visual[not(@bg)]]" mode="background-color">
	black
  </xsl:template>
</xsl:stylesheet>
