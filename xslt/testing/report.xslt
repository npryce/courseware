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
	
	<p class="summary">
	  <xsl:value-of select="count(//test:assert)"/> tests:
	  <xsl:value-of select="count(//test:assert[@result='passed'])"/> passed,
	  <xsl:value-of select="count(//test:assert[@result='failed'])"/> failed.
	</p>
	
	<xsl:apply-templates/>
      </body>
    </html>
  </xsl:template>
  
  <xsl:template match="test:suite">
    <div class="suite">
      <xsl:apply-templates/>
    </div>
  </xsl:template>
  
  <xsl:template match="test:fixture">
    <div class="fixture">
      <p>
	<span class="name"><xsl:value-of select="@name"/></span>
	<xsl:apply-templates select="test:definition"/>
	&#8594;
	<xsl:apply-templates select="test:value"/>
      </p>
    </div>
  </xsl:template>

  <xsl:template match="test:definition[@select]">
    = <xsl:value-of select="@select"/>
  </xsl:template>
  
  <xsl:template match="test:definition[not(@select)]">
    <span class="inlineDefinition">
      <xsl:apply-templates mode="xmlverb"/>
    </span>
  </xsl:template>
  
  <xsl:template match="test:value">
    <span class="inlineDefinition">
      <xsl:apply-templates mode="xmlverb"/>
    </span>
  </xsl:template>
  
  <xsl:template match="test:assert">
    <div class="assert {@result}">
      <xsl:value-of select="@that"/>
    </div>
  </xsl:template>
  
  <xsl:template match="@*|node()">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
  </xsl:template>
</xsl:stylesheet>
