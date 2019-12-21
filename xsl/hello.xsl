<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output indent="yes" method="html" encoding="UTF-8" />
<xsl:template match="/">
<html>
<body>
<h2>My CD Collection</h2>
 
<xsl:variable name="header">
	<tr bgcolor="#9acd32">
		<th>Title</th>
		<th>Artist</th>
		<th>COM.</th>
		<th>year</th>
		<th>a的值</th>
  </tr>
</xsl:variable>
<xsl:variable name="header2" select="$header" />	
<table border="1">
<xsl:copy-of select="$header" />
<xsl:copy-of select="$header2" />
<tr bgcolor="#9acd32">
<th>Title</th>
<th>Artist</th>
<th>COM.</th>
<th>year</th>
<th>a的值</th>
</tr>
<xsl:for-each select="catalog/cd[year &lt; 1986]">
<!--> 
合法的过滤运算符:
:=  (等于)　
:!= (不等于)
:&lt; (小于)
:&gt; (大于)　　
如需对结果进行排序，只要简单地在 XSL 文件中的 <xsl:for-each> 元素内部添加一个 <xsl:sort> 
 <-->
 <xsl:sort select="year"/>  
<tr>
 <xsl:if test="title='tt'">
	<td>
   <xsl:value-of select="title"/>这是tt
 </td>
	
</xsl:if>
<xsl:if test="title!='tt'">
	<td>
  <xsl:value-of select="title"/>  编号： <xsl:value-of select="@index"/>           标题序号：<xsl:value-of select="title/@name"/> <!--> 取属性值 <-->
  </td>
	
</xsl:if>
 
<td>
<xsl:value-of select="artist"/>
</td>
<td>
<xsl:value-of select="company"/>
</td>
 
<xsl:choose> 
<xsl:when test="year &gt; 1980"> 
<td>
<xsl:value-of select="year"/><h6>80年代以后</h6>
</td>
</xsl:when>
<xsl:when test="year &lt; 1980"> 
<td>
<xsl:value-of select="year"/><h6>80年代以前</h6>
</td>
</xsl:when>
<xsl:otherwise> 
<td>
<xsl:value-of select="year"/><h6>未识别</h6>
</td>
</xsl:otherwise>
</xsl:choose>
<xsl:if test="a">  
<td>
<xsl:value-of select="a"/>
</td>
</xsl:if>
 
<xsl:if test="not(a) ">  
<td>
不存在a
</td>
</xsl:if>
<!--> 
判断多个节点是否同时存在:    <xsl:if test="a | b | c">  
判断多个节点是否至少有一个存在:    <xsl:if test="a or b or c">  
<-->
</tr>
</xsl:for-each>
</table>
</body>
</html>
</xsl:template>
</xsl:stylesheet>
