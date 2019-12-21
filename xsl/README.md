xsl文件可以理解为一种数据展示格式定义
xml文件或jtl文件可以理解为数据源，都遵循xml格式标准

第一种显示方式:
1. Xml文件是数据源
2. Xsl文件是格式定义，在xml文件中引用xsl文件
3. 在本地架起http-server(python3 -m http.server)，通过http方式打开xml(http://localhost:8000/hello.xml)
4. 如果想修改数据源查看效果，直接打开xml文件编辑


第二种显示方式
1. Jtl文件是数据源
2. 用xslproc命令将通过xsl文件将jtl文件导出为html文件
3. xsltproc -o test.html test.xsl test.jtl
4. 在本地架起http-server(python3 -m http.server)，通过http方式打开html(http://localhost:8000/test.html)
5. 如果想修改数据源查看效果，直接打开jtl文件编辑