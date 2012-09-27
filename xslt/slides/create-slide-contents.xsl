<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:fo="http://www.w3.org/1999/XSL/Format"
		xmlns:fox="http://xml.apache.org/fop/extensions">
  
  <xsl:template name="create-slide-contents">
    <fo:page-sequence master-reference="contents"
		      initial-page-number="1">
      <fo:flow flow-name="xsl-region-body" padding="0" color="black">
	<xsl:apply-templates />
      </fo:flow>
    </fo:page-sequence>
  </xsl:template>
</xsl:stylesheet>