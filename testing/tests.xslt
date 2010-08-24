<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
		xmlns="http://www.w3.org/1999/xhtml"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:fn="http://www.w3.org/2005/xpath-functions"
		xmlns:cw="http://www.natpryce.com/courseware/1.0"
		xmlns:test="http://www.natpryce.com/testxslt/1.0">
  
  <xsl:import href="../xslt/queries/functions.xslt"/>
  
  <xsl:output method="xml" indent="yes"/>
  
  <xsl:template name="tests">
    <test:suite>
      <h2>Custom functions</h2>
      
      <test:suite>
	<h3>The basename function</h3>
	
	<xsl:variable name="b1" select="cw:basename('/foo/bar/file1.ext')"/>
	<test:assert that="$b1 = 'file1'">
	  basename of absolute file
	</test:assert>
	
	<xsl:variable name="b2" select="cw:basename('foo/bar/file2.ext')"/>
	<test:assert that="$b2 = 'file2'">
	  basename of relative file
	</test:assert>
	
	<xsl:variable name="b3" select="cw:basename('/foo/bar/file3.ext')"/>
	<test:assert that="$b3 = 'file3'">
	  basename of absolute file with no extension
	</test:assert>
	
	<xsl:variable name="b4" select="cw:basename('foo/bar/file4')"/>
	<test:assert that="$b4 = 'file4'">
	  basename of relative file with no extension
	</test:assert>
      </test:suite>
      
      <test:suite>
	<h3>The path-of-uri function</h3>
	<xsl:variable name="p1" select="cw:path-of-uri('file:/foo/bar/file1.ext')"/>
	<test:assert that="$p1 = '/foo/bar/file1.ext'">
	  path of file: URI
	</test:assert>
	
	<xsl:variable name="p2" select="cw:path-of-uri('http://www.example.com')"/>
	<test:assert that="$p2 = ''">
	  path of other kind of URI returns an empty string
	</test:assert>
      </test:suite>
    </test:suite>
  </xsl:template>
</xsl:stylesheet>
