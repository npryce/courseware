<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:fn="http://www.w3.org/2005/xpath-functions"
		xmlns:test="http://www.natpryce.com/testxslt/1.0">
  
  <xsl:output method="text"/>
  
  <xsl:template match="/">
    <xsl:variable name="failures" select="count(//test:assert[@result='failed'])"/>
    
    <xsl:if test="$failures != 0">
      <xsl:value-of select="error(test:failed, concat($failures,' test failures!'))"/>
    </xsl:if>
  </xsl:template>	
</xsl:stylesheet>
