<?xml version="1.0" encoding="iso-8859-1"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html" encoding="iso-8859-1" indent="yes"/>
<xsl:preserve-space elements="text"/>

<xsl:param name="show-alias" select="yes"/>
	<xsl:template match="/">
	   <xsl:apply-templates />
	</xsl:template>


	<xsl:template match="plotscript">
		<html>
			<head>
				<title>Dictionary of Plotscripting Commands</title>
				<style type="text/css">
<![CDATA[
					body,p,h1,h2,h3,h4,h5,h6 {
						color: white;
						background-color: black;
					}

					h2 {
						font-style: italic;
					}

					h3 {
						color: #f06060;
					}

					h4 {
						color: yellow;
					}

					pre {
						background-color:#FFFFFF;
						color:#000000;
						border-width:3px;
						border-style:ridge;
						padding:10px;
						padding-left:20px;
						/*font-family:fixedsys,monospace;*/
					}

					a {
						color:#00ff00;
					}
					a:active {
						color: #d0d000;
					}
					a:visited {
						color: #009090;
					}

					a.undef {
						font-weight:bold;
						color:red;
					}
					
					a.ref:after {
						/*content: " ?";*/
					}
					
					.key, .param {
						font-weight: bold;
						color: yellow;
					}
					
					/*.param {
						color: yellow;
					}*/
					
					.seealso {
						display: inline;
						margin:0;
						padding:0;
					}
					
					.seealso li {
						display: inline;
						
					}
]]>
				</style>
			</head>
			<body>
				<h1>Plotscripting Dictionary</h1>
				<p>This is a listing of all the plotscripting commands implemented as of <xsl:value-of select="@lastmodified" />.</p>
				<p>In addition to reading this document, I also recommend you check out Plotscripting Tutorial and the HamsterSpeak Specification</p>
				<hr/>
				<h2>Commands by Category</h2>
				<p>
				<xsl:apply-templates select="section" mode="sections"/>
				</p>
				<hr/>
				<h2>Alphabetical Index</h2>
				<p>
				<xsl:apply-templates select=".//command" mode="alphalist">
				<xsl:sort select="@id" data-type="text" />
				</xsl:apply-templates>
				</p>
				<hr/>
				<xsl:apply-templates select="section" mode="full" />
				<p>Stats: There are <xsl:value-of select='count(//command)'/> commands in this file, of which <xsl:value-of select='count(//alias)'/> are only references to other commands.</p>
				<p>This file was generated from an XML file. The contents were painstakingly transcribed by Mike Caron from the original Plotscripting Dictionary, which was created by James Paige.</p>
			</body>
		</html>
	</xsl:template>

	<xsl:template match="section" mode="sections"><xsl:text>
		</xsl:text><a href="#{@title}"><xsl:value-of select="@title" /></a><br/><xsl:text>
	</xsl:text></xsl:template>

	<xsl:template match="command" mode="alphalist"><xsl:text>
		</xsl:text><xsl:if test='boolean(cannon)'>
			<a href="#about-{@id}"><xsl:value-of select="cannon" /></a><br/>
		</xsl:if><xsl:text>
		</xsl:text><xsl:if test='boolean(alias)'>
			<a href="#about-{alias}"><xsl:value-of select="shortname" /></a><br/>
		</xsl:if><xsl:text>
	</xsl:text></xsl:template>

	<xsl:template match="section" mode="full"><xsl:text>
		</xsl:text><a name="{@title}" ></a><xsl:text>
		
		</xsl:text><font color="#f06060" size="4"><xsl:value-of select="@title" /></font><xsl:text>
		</xsl:text><p><xsl:apply-templates select="description"/></p><xsl:text>
		</xsl:text><xsl:apply-templates select="command" mode="full" /><xsl:text>
		
		</xsl:text><hr></hr><xsl:text>
	</xsl:text></xsl:template>

	<xsl:template match="command" mode="full"><xsl:text>
		</xsl:text><a name="about-{@id}" ></a><xsl:text>
		</xsl:text><p><xsl:text>
		</xsl:text><tt><xsl:text>
		</xsl:text><xsl:if test='boolean(cannon)'>
			<b><font color="yellow"><xsl:value-of select="cannon" /></font></b><br/><xsl:text>
			</xsl:text><xsl:apply-templates select="description" /><xsl:text>
			</xsl:text><xsl:apply-templates select="example" /><xsl:text>
			</xsl:text><xsl:apply-templates select="seealso" /><xsl:text>
		</xsl:text></xsl:if>
		<xsl:if test='boolean(alias)'><xsl:text>
				</xsl:text><b><font color="yellow"><xsl:value-of select="shortname" /></font></b><br/><xsl:text>
				</xsl:text>See <a href="#about-{alias}"><xsl:value-of select="id(alias)/shortname" /></a><xsl:text>
			</xsl:text>
		</xsl:if>
		</tt>
		</p>
	</xsl:template>

	<xsl:template match="description"><xsl:apply-templates /></xsl:template>
	<xsl:template match="ul"><ul><xsl:apply-templates /></ul></xsl:template>
	<xsl:template match="li"><li><xsl:apply-templates /></li></xsl:template>

	<xsl:template match="example">
		<xsl:if test='@c'>
			<pre><xsl:value-of select="id(@c)/example" /></pre>
		</xsl:if>
		<xsl:if test="not(@c)">
			<pre><xsl:value-of select="." /></pre>
		</xsl:if>
	</xsl:template>
	
	<xsl:template match="p"><span class="key"><xsl:value-of select="." /></span></xsl:template>
	<xsl:template match="ref">
		<xsl:if test='count(id(.))=0'>
			<a href="#{.}" class="undef"><xsl:value-of select='.' /></a>
		</xsl:if>
		<xsl:if test='count(id(.))>0'>
			<xsl:if test='not(id(.)/alias)'>
				<a href="#about-{.}" class="ref"><xsl:value-of select='id(.)/shortname' /></a>
			</xsl:if>
			<xsl:if test='id(.)/alias'>
				<a href="#about-{id(.)/alias}" class="ref"><xsl:value-of select='id(.)/shortname' /></a>
			</xsl:if>
		</xsl:if>
	</xsl:template>
	<xsl:template match="seealso"><br /><br />See also: <ul class="seealso"><xsl:apply-templates select="ref" mode="seealso"/></ul></xsl:template>
	<xsl:template match="ref" mode="seealso"><li><xsl:if test='count(id(.))=0'>
			<a href="#{.}" class="undef"><xsl:value-of select='.' /></a>
		</xsl:if>
		<xsl:if test='count(id(.))>0'>
			<xsl:if test='not(id(.)/alias)'>
				<a href="#about-{.}" class="ref"><xsl:value-of select='id(.)/shortname' /></a>
			</xsl:if>
			<xsl:if test='id(.)/alias'>
				<a href="#about-{id(.)/alias}" class="ref"><xsl:value-of select='id(.)/shortname' /></a>
			</xsl:if>
		</xsl:if><xsl:if test="not(position() = last())">, </xsl:if></li></xsl:template>

	<xsl:template match="lb"><br/></xsl:template>
	
	<xsl:template match="p"><span class="param"><xsl:apply-templates /></span></xsl:template>

</xsl:stylesheet>

