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

<!-- this styilesheet selects all the embedded MMT elements
currently the placeholders are ^^1e and ^] for the real MMT
delimiters -->

<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:omdoc="http://omdoc.org/ns"
  xmlns="http://omdoc.org/ns"
  xmlns:ltx="http://dlmf.nist.gov/LaTeXML"
  xmlns:stex="http://kwarc.info/ns/sTeX"
  xmlns:dc="http://purl.org/dc/elements/1.1/"
  exclude-result-prefixes="xsl ltx">

<!-- get the current file name -->
<xsl:param name="fileName"/>
  
 <!-- Get rid of xml header -->
 <xsl:output method="xml" indent="yes" cdata-section-elements="data"
	       omit-xml-declaration="yes" />

<!-- Remove everything until a match -->
<xsl:template match="@* | node()">
  <xsl:apply-templates select="@* | node()" />
</xsl:template>

<!-- Add namespace and document ending -->
<xsl:template match="/">
  namespace http://cds.omdoc.org/<xsl:value-of select="$fileName" />^]
  <xsl:apply-templates/>
  ^]
</xsl:template >
  
<!-- Ignore text content of nodex -->
<xsl:template match="text()" />
<xsl:template match="text()" mode="mmt" />

<!-- Module stuff -->
<xsl:template match="omdoc:theory">
    theory <xsl:value-of select="@xml:id" /> : http://kwarc.info/<xsl:value-of select="substring-before($fileName,
    '.')" />?FOL =
    <xsl:apply-templates/>
    ^]
</xsl:template>

<!-- include/import module -->
<xsl:template match="omdoc:imports">
    include ?<xsl:value-of select="substring-after(@from, '#')" />^^1e
</xsl:template>

<!-- If find mmt, copy over -->
<xsl:template name = "mmtEnv" match="*[@class='ltx_text mmt']" >
  <xsl:param name = "moduleName"  />
  <xsl:value-of select="." />
   //end <xsl:value-of
   select="../../preceding-sibling::omdoc:oref[1]/@href" />
   <!-- When importmodule exists -->
   <xsl:value-of select="preceding-sibling::omdoc:oref[1]/@href" />
</xsl:template >

<!-- MMT env -->
<xsl:template match="*[@class='ltx_text mmt']" >
    # :mmt1 ^^1e
  <xsl:value-of select="." />
</xsl:template>

<!-- If find oref, store the crossref
<xsl:template match="omdoc:oref" >
    <xsl:apply-templates select="preceding-sibling::*" mode="mmt" />
    //<xsl:value-of select="@href" />
    <xsl:text>&#xa;</xsl:text>
</xsl:template > -->

<!--
<xsl:template match="omdoc:imports" mode="mmt">
  theory <xsl:value-of select="substring-after(@from, '#')" /> =
  include ?<xsl:value-of select="substring-after(@from, '#')" />
</xsl:template> -->

</xsl:stylesheet>
