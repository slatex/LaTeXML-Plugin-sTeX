<?xml version="1.0" encoding="utf-8"?>
<!-- An XSL style sheet for transforming LaTeXML islands to OMDoc (Open Mathematical Documents). 
     $Id: math.xsl 1728 2011-02-06 16:22:09Z kohlhase $
     $HeadURL: https://svn.kwarc.info/repos/stex/branches/stex+xhtml/xsl/math.xsl $
     send bug-reports, patches, suggestions to users@omdoc.org or developers@omdoc.org 

     Copyright (c) 2000 - 2002 Michael Kohlhase, 
     XSLT 2.0 port by Christoph Lange 2006

     This library is free software; you can redistribute it and/or
     modify it under the terms of the GNU Lesser General Public
     License as published by the Free Software Foundation; either
     version 2.1 of the License, or (at your option) any later version.

     This library is distributed in the hope that it will be useful,
     but WITHOUT ANY WARRANTY; without even the implied warranty of
     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
     Lesser General Public License for more details.

     You should have received a copy of the GNU Lesser General Public
     License along with this library; if not, write to the Free Software
     Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-->
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:omdoc="http://omdoc.org/ns"
  xmlns="http://omdoc.org/ns"
  xmlns:ltx="http://dlmf.nist.gov/LaTeXML"
  xmlns:stex="http://kwarc.info/ns/sTeX"
  xmlns:dc="http://purl.org/dc/elements/1.1/"
  exclude-result-prefixes="xsl ltx">

<xsl:output method="xml" indent="yes" cdata-section-elements="data"/>

<!-- Remove everything until a match -->
<xsl:template match="@* | node()">
  <xsl:apply-templates select="@* | node()"/>
</xsl:template>

<!-- Ignore text content of nodex -->
  <xsl:template match="text()" />
  <xsl:template match="text()" mode="mmt" />

<!-- If find mmt, copy over -->
<xsl:template name = "mmtEnv" match="*[@class='ltx_text mmt']" >
  <xsl:param name = "moduleName"  />
  <xsl:value-of select="normalize-space(.)"/>
   //end <xsl:value-of select="preceding-sibling::omdoc:oref[1]/@href" />
</xsl:template >

<!-- If find oref, store the crossref-->
<xsl:template match="omdoc:oref" >
    <xsl:apply-templates select="preceding-sibling::*" mode="mmt"/>
    //<xsl:value-of select="@href" />
    <xsl:text>&#xa;</xsl:text>
</xsl:template >

<xsl:template match="omdoc:imports" mode="mmt">
  theory <xsl:value-of select="substring-after(@from, '#')" />
  include ?<xsl:value-of select="substring-after(@from, '#')" />
</xsl:template>



</xsl:stylesheet>
