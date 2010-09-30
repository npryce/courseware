<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:fo="http://www.w3.org/1999/XSL/Format"
		xmlns:fox="http://xml.apache.org/fop/extensions">
  
  <xsl:template match="para">
    <fo:block space-before="0.5em">
      <xsl:apply-templates />
    </fo:block>
  </xsl:template>
  
  <xsl:template match="programlisting|literallayout">
    <fo:block font-family="Courier, monospace"
	      font-style="normal"
	      font-size="smaller"
	      text-align="start" 
	      wrap-option="no-wrap" 
	      space-before.minimum="0.8em"
	      space-before.optimum="1em" 
	      space-before.maximum="1.2em"
	      space-after.minimum="0.8em" 
	      space-after.optimum="1em"
	      space-after.maximum="1.2em" 
	      hyphenate="false"
	      white-space-collapse="false" 
	      white-space-treatment="preserve"
	      linefeed-treatment="preserve"
	      widows="4"
	      orphans="4">
      <xsl:apply-templates />
    </fo:block>
  </xsl:template>
  
  <xsl:template match="emphasis[@role='strong']">
    <fo:inline font-weight="bold">
      <xsl:apply-templates />
    </fo:inline>
  </xsl:template>
  
  <xsl:template match="emphasis">
    <fo:inline font-style="italic">
      <xsl:apply-templates />
    </fo:inline>
  </xsl:template>
  
  <xsl:template match="code|classname|interfacename|methodname">
    <fo:inline font-family="Courier">
      <xsl:apply-templates />
    </fo:inline>
  </xsl:template>
</xsl:stylesheet>
