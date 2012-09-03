<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fo="http://www.w3.org/1999/XSL/Format">
    <xsl:template match="link">
        <fo:basic-link external-destination="{@href}" text-decoration="underline" color="blue">
            <xsl:value-of select="."/>
        </fo:basic-link>
    </xsl:template>

</xsl:stylesheet>