<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:fn="http://www.w3.org/2005/xpath-functions"
		xmlns:test="http://www.natpryce.com/testxslt/1.0"
		xmlns:xslo="http://www.natpryce.com/testxslt/1.0/xsltoutput">
  
  <xsl:output method="xml" indent="yes"/>
  <xsl:namespace-alias stylesheet-prefix="xslo" result-prefix="xsl"/>
  
  <xsl:template match="test:assert">
    <xslo:variable name="{@as}" select="{@that}"/>
    
    <test:assert>
      <xsl:apply-templates select="@*"/>
      
      <xslo:attribute name="result">
	<xslo:choose>
	  <xslo:when test="{@satisfies}">passed</xslo:when>
	  <xslo:otherwise>failed</xslo:otherwise>
	</xslo:choose>
      </xslo:attribute>
      
      <xsl:apply-templates/>
      
      <xslo:if test="not({@satisfies})">
	<test:actual><xslo:copy-of select="{@that}"/></test:actual>
      </xslo:if>
    </test:assert>
  </xsl:template>
  
  <xsl:template match="@*|node()">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
  </xsl:template>
</xsl:stylesheet>
