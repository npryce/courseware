<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" 
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
		xmlns:fo="http://www.w3.org/1999/XSL/Format" 
		xmlns:fox="http://xml.apache.org/fop/extensions">
  <!-- @author $Author: romilly $ -->
  <!--  @version $Revision: 1.1 $  -->
  <!--  $Date: 2007/11/24 07:47:37 $ -->
  <xsl:output method="xml" indent="no"/>
  <xsl:template name="create-page-layouts">
    <fo:layout-master-set>
      <!-- spm for title page-->
      <fo:simple-page-master master-name="title" 
			     page-height="29.7cm" 
			     page-width="21cm" 
			     margin-top="2.5cm"
			     margin-bottom="2cm"
			     margin-left="2.5cm"
			     margin-right="2.5cm">
	<fo:region-body margin-top="1.5cm"
			margin-bottom="1.5cm"
			margin-left="1.5cm"
			margin-right="1cm"/>
	<fo:region-before region-name="title-before" extent="1cm"/>
	<fo:region-after region-name="title-after" extent="2cm"/>
      </fo:simple-page-master>
      
      <!-- spm for frontispiece -->
      <fo:simple-page-master master-name="frontispiece" 
			     page-height="29.7cm"
			     page-width="21cm" 
			     margin-top="2.5cm"
			     margin-bottom="3cm"
			     margin-left="2.5cm"
			     margin-right="2.5cm">
	<fo:region-body margin-top="1.5cm"
			margin-bottom="1.5cm"
			margin-left="1cm" 
			margin-right="1.5cm"/>
	<fo:region-before region-name="frontispiece-before" extent="1cm"/>
	<fo:region-after region-name="frontispiece-after" extent="2cm"/>
      </fo:simple-page-master>
      
      <!-- spm for odd contents page -->
      <fo:simple-page-master master-name="contents-odd" 
			     page-height="29.7cm"
			     page-width="21cm"
			     margin-top="1.5cm"
			     margin-bottom="1cm" 
			     margin-left="1.5cm" margin-right="1cm">
	<fo:region-body margin-bottom="1cm"/>
	<fo:region-before region-name="contents-odd-before" extent="1cm"/>
	<fo:region-after region-name="contents-odd-after" extent="1cm"/>
      </fo:simple-page-master>
      
      <!-- spm for even contents page -->
      <fo:simple-page-master master-name="contents-even" 
			     page-height="29.7cm"
			     page-width="21cm"
			     margin-top="1.5cm"
			     margin-bottom="1cm"
			     margin-left="1cm"
			     margin-right="1.5cm">
	<fo:region-body margin-bottom="1cm"/>
	<fo:region-before region-name="contents-even-before" extent="1cm"/>
	<fo:region-after region-name="contents-even-after" extent="1cm"/>
      </fo:simple-page-master>
      
      <fo:simple-page-master master-name="blank"
			     page-height="29.7cm"
			     page-width="21cm" 
			     margin-top="2.5cm" 
			     margin-bottom="1cm" 
			     margin-left="2cm" 
			     margin-right="2.5cm">
	<fo:region-body margin-bottom="1cm"/>
	<fo:region-before region-name="blank-before" extent="1cm"/>
	<fo:region-after region-name="blank-after" extent="1cm"/>
      </fo:simple-page-master>
      
      <fo:page-sequence-master master-name="contents">
	<fo:repeatable-page-master-alternatives>
	  <fo:conditional-page-master-reference master-reference="contents-odd" 
						odd-or-even="odd"/>
	  <fo:conditional-page-master-reference master-reference="blank" 
						blank-or-not-blank="blank"/>
	  <fo:conditional-page-master-reference master-reference="contents-even" 
						odd-or-even="even"/>
	</fo:repeatable-page-master-alternatives>
      </fo:page-sequence-master>
    </fo:layout-master-set>
  </xsl:template>
</xsl:stylesheet>