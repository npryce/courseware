<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:fo="http://www.w3.org/1999/XSL/Format"
		xmlns:fox="http://xml.apache.org/fop/extensions">
  
  <xsl:template match="procedure">
    <fo:list-block start-indent="2em" space-before="0.5em"
		   space-before.conditionality="retain"
		   provisional-distance-between-starts="7mm">
      <xsl:apply-templates />
    </fo:list-block>
  </xsl:template>
  
  <xsl:template match="step">
    <fo:list-item>
      <fo:list-item-label end-indent="label-end()">
	<fo:block>
	  <xsl:number level="multiple" count="step"
		      format="1.1.a. " />
	</fo:block>
      </fo:list-item-label>
      <fo:list-item-body start-indent="body-start()"
			 end-indent="1em">
	<fo:block>
	  <xsl:apply-templates />
	</fo:block>
      </fo:list-item-body>
    </fo:list-item>
  </xsl:template>
  
  <xsl:template match="substeps">
    <fo:list-block start-indent="4em" space-before="10pt"
		   space-after="10pt" space-after.conditionality="retain"
		   provisional-distance-between-starts="10mm">
      <xsl:apply-templates />
    </fo:list-block>
  </xsl:template>
</xsl:stylesheet>