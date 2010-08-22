<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:fn="http://www.w3.org/2005/xpath-functions"
		xmlns:cw="http://www.natpryce.com/courseware/1.0"
		xmlns:test="http://www.natpryce.com/testxslt/1.0">
  
  <xsl:import href="../xslt/queries/functions.xslt"/>
  
  <xsl:output method="xml" indent="yes"/>
  
  <xsl:template name="tests">
    <test:suite>
      Custom functions
      
      <test:suite>
	The basename function
	
	<test:assert that="cw:basename('/foo/bar/file1.ext')" as="b"
		     satisfies="$b = 'file1xxx'">
	  basename of absolute file
	</test:assert>
	<test:assert that="cw:basename('/foo/bar/file2.ext')" as="b"
		     satisfies="$b = 'file2'">
	  basename of relative file
	</test:assert>
	<test:assert that="cw:basename('/foo/bar/file3.ext')" as="b"
		     satisfies="$b = 'file3'">
	  basename of absolute file with no extension
	</test:assert>
	<test:assert that="cw:basename('foo/bar/file4')" as="b"
		     satisfies="$b = 'file4'">
	  basename of relative file with no extension
	</test:assert>
      </test:suite>
    </test:suite>
  </xsl:template>
</xsl:stylesheet>
