<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:fn="http://www.w3.org/2005/xpath-functions"
		xmlns:fo="http://www.w3.org/1999/XSL/Format"
		xmlns:fox="http://xml.apache.org/fop/extensions">
  
   <xsl:template match="notes">
     <fo:block font-size="12pt">
       <xsl:apply-templates select="student" />
       <xsl:if test="$format = 'Presenter'">
	 <xsl:apply-templates select="presenter" />
       </xsl:if>
     </fo:block>
   </xsl:template>
   
   <xsl:template match="student">
     <fo:block font-size="14pt" 
	       font-style="italic"
	       space-before="10pt">
       Notes:
     </fo:block>
     <xsl:apply-templates select="*" />
   </xsl:template>
   
   <xsl:template match="presenter">
     <fo:block break-before="page">
       <fo:block space-before="10pt">Instructor notes:</fo:block>
       <fo:block text-align-last="justify" 
		 font-size="1pt">
	 <fo:leader leader-pattern="rule" 
		    rule-thickness="2pt" />
       </fo:block>
       <fo:block font-size="12pt">
	 <xsl:apply-templates />
       </fo:block>
     </fo:block>
   </xsl:template>
</xsl:stylesheet>