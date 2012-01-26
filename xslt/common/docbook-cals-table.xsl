<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" 
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
		xmlns:fo="http://www.w3.org/1999/XSL/Format" 
		xmlns:fox="http://xml.apache.org/fop/extensions">
  
  <xsl:template match="informaltable">
    <fo:table border="black solid 1px"
	      table-layout="fixed"
	      space-before="1em"
	      space-after="1em"
	      width="100%"
	      border-collapse="separate"
	      keep-together="always"
	      text-align="start">
      
      <xsl:call-template name="add-cols">
	<xsl:with-param name="count" select="1" />
	<xsl:with-param name="max" select="number(tgroup/@cols)" />
      </xsl:call-template>
      
      <fo:table-header>
	<xsl:apply-templates select="tgroup/thead/row" />
      </fo:table-header>
      
      <fo:table-body>
	<xsl:apply-templates select="tgroup/tbody/row" />
      </fo:table-body>
    </fo:table>
  </xsl:template>
  
  <xsl:template name="add-cols">
    <xsl:param name="count"/>
    <xsl:param name="max"/>
    
    <xsl:message>add-cols: count=<xsl:value-of select="$count"/>, max=<xsl:value-of select="$max"/></xsl:message>
    
    <fo:table-column column-number="{$count}" column-width="proportional-column-width(1)"/> 
    <xsl:if test="$max > $count">
      <xsl:call-template name="add-cols">
	<xsl:with-param name="count" select="$count + 1"/>
	<xsl:with-param name="max" select="$max"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>
  
  <xsl:template match="row">
    <fo:table-row text-align="start">
      <xsl:apply-templates  select="entry" />
    </fo:table-row>
  </xsl:template>
  
  <xsl:template match="entry">
    <fo:table-cell border="black solid 0.5px" start-indent="5px" padding="3pt">
      <fo:block text-align="start" font-size="11pt">
	<xsl:apply-templates/>
      </fo:block>
    </fo:table-cell>
  </xsl:template>
</xsl:stylesheet>
