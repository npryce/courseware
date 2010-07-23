<?xml version="1.0"?>

<xsl:stylesheet version="2.0" 
   xmlns="http://www.w3.org/2000/svg"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:dc="http://purl.org/dc/elements/1.1/"
   xmlns:cc="http://creativecommons.org/ns#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
   xmlns:svg="http://www.w3.org/2000/svg"
   xmlns:sodipodi="http://sodipodi.sourceforge.net/DTD/sodipodi-0.dtd"
   xmlns:inkscape="http://www.inkscape.org/namespaces/inkscape"
  >
  <xsl:output method="xml" indent="yes"/>
  
  <xsl:param name="step"/>
  
  <xsl:template match="svg:g[@inkscape:groupmode='layer']">
    <xsl:variable name="minStep">
      <xsl:call-template name="min-step">
        <xsl:with-param name="label" select="@inkscape:label"/>
      </xsl:call-template>
    </xsl:variable>
    
    <xsl:variable name="maxStep">
     <xsl:call-template name="max-step">
       <xsl:with-param name="label" select="@inkscape:label"/>
     </xsl:call-template>
    </xsl:variable>
    
    <xsl:if test="$minStep &lt;= $step and $step &lt;= $maxStep">
     <g>
      <xsl:apply-templates select="@*[name()!='style']"/>
      <xsl:attribute name="style">display: inline;</xsl:attribute>
      <xsl:apply-templates select="node()"/>
     </g>
    </xsl:if>
  </xsl:template>
  
  <xsl:template name="min-step">
    <xsl:param name="label"/>
    
    <xsl:choose>
      <xsl:when test="contains($label, '+')">
        <xsl:value-of select="number(substring-before($label, '+'))"/>
      </xsl:when>
      <xsl:when test="contains($label, '-')">
        <xsl:value-of select="number(substring-before($label, '-'))"/>
      </xsl:when>
      <xsl:when test="contains($label, ' only')">
        <xsl:value-of select="number(substring-before($label, ' only'))"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="0"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <xsl:template name="max-step">
    <xsl:param name="label"/>
    
    <xsl:choose>
      <xsl:when test="contains($label, '+')">
        <xsl:value-of select="999"/>
      </xsl:when>
      <xsl:when test="contains($label, '-')">
        <xsl:value-of select="number(substring-after($label, '-'))"/>
      </xsl:when>
      <xsl:when test="contains($label, ' only')">
        <xsl:value-of select="number(substring-before($label, ' only'))"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="999"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <xsl:template match="@*|node()">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
  </xsl:template>
</xsl:stylesheet>

