<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:fo="http://www.w3.org/1999/XSL/Format"
   xmlns:fox="http://xml.apache.org/fop/extensions">
  
  <xsl:template match="slide">
    <fo:block break-before="">
      <xsl:choose>
	<xsl:when test="$format = 'Presenter'">
	  <xsl:attribute name="break-before">even-page</xsl:attribute>
	</xsl:when>
	<xsl:otherwise>
	  <xsl:attribute name="break-before">page</xsl:attribute>
	</xsl:otherwise>
      </xsl:choose>
      <fo:block font-size="24pt">
	<xsl:value-of select="title" />
      </fo:block>
      <fo:block text-align-last="justify" 
		font-size="1pt" 
		space-after="14pt" 
		space-after.conditionality="retain">
	<fo:leader leader-pattern="rule" rule-thickness="2pt" />
      </fo:block>
      <fo:block>
	<xsl:if
	    test="visual and (string-length(visual/@fileref) > 0)">
	  <fo:block text-align="center">
	    <fo:external-graphic 
		height="120mm"
		width="185mm"
		content-height="scale-to-fit"
		content-width="scale-to-fit"
		src="url({visual/@fileref})" />
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
</xsl:stylesheet>