<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:fox="http://xml.apache.org/fop/extensions">
	<!-- @author $Author: romilly $ -->
	<!--  @version $Revision: 1.1 $  -->
	<!--  $Date: 2007/11/24 07:47:37 $ -->
	<xsl:output method="xml" indent="no"/>
	<xsl:template name="create-slide-layout">
		<fo:layout-master-set>
			<!-- simple page master for contents page -->
			<fo:simple-page-master master-name="slide-contents" page-height="768px" page-width="1024px">
				<fo:region-body/>
			</fo:simple-page-master>
			<!-- sequence maseter contents page -->
			<fo:page-sequence-master master-name="contents">
				<fo:repeatable-page-master-reference master-reference="slide-contents"/>
			</fo:page-sequence-master>
		</fo:layout-master-set>
	</xsl:template>
</xsl:stylesheet>
