<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0"
		xmlns="http://www.w3.org/1999/xhtml"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:test="http://www.natpryce.com/testxslt/1.0"
		exclude-result-prefixes="test">
  
  <xsl:import href="xmlverbatim.xslt"/>
  
  <xsl:output method="xhtml"
	      indent="yes"
	      encoding="utf-8"
	      />
  
  <xsl:param name="title">Test Results</xsl:param>
  <xsl:param name="css" select="resolve-uri('report.css')"/>
  
  <xsl:template match="/">
    <html>
      <head>
	<title><xsl:copy-of select="$title"/></title>
	<link rel="stylesheet" type="text/css" href="{$css}"/>
      </head>
      <body>
	<h1><xsl:copy-of select="$title"/></h1>
	
	<xsl:apply-templates/>
      </body>
    </html>
  </xsl:template>
  
  <xsl:template match="test:suite">
    <div class="suite">
      <xsl:apply-templates/>
    </div>
  </xsl:template>
  
  <xsl:template match="test:assert">
    <div class="assert {@result}">
      <xsl:apply-templates select="* except test:actual"/>
      <p class="expected">
	<xsl:value-of select="@as"/> = <xsl:value-of select="@that"/> &#8594;
	<xsl:value-of select="@satisfies"/>
      </p>
      <xsl:apply-templates select="test:actual"/>
    </div>
  </xsl:template>
  
  <xsl:template match="test:actual">
    <p class="actual">
      Actual: <xsl:apply-templates mode="xmlverb"/>
    </p>
  </xsl:template>
</xsl:stylesheet>
