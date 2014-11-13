druidme
=======

a simle web query ui for druid.

we use it to test the data ingested by Druid. and it works well.

now it support three query types : 
1. TopN
2. GroupBy
3. Timeseries 

the UI looks like this :

![此处输入图片的描述][1]

we don't use the `Coordinator Node` to get the MetaData of your datasource. so before you can your query works ,you must fill your broker info .

![此处输入图片的描述][2]

this's a [grails][3] project, it use `h2` database. you can use the following command to generate the `war` file.

```shell
cd druidme
grails prod war
```

then you can run the generated `target/ROOT.war` by [tomcat][4] or [jetty][5] .

we also provide a war file at [dropbox][6] ,so you can just download it without compile.


> thanks for the [Sql4D][6] project. we use it to generate druid's query api of json format.



  [1]: http://crnsnlzc.qiniudn.com/Snip20141113_2.png
  [2]: http://crnsnlzc.qiniudn.com/Snip20141113_3.png
  [3]: https://grails.org
  [4]: http://tomcat.apache.org
  [5]: http://www.eclipse.org/jetty/
  [6]: https://www.dropbox.com/s/ipoezwgf7p3aza2/ROOT.war?dl=0