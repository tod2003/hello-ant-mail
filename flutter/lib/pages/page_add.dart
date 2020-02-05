import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class SecondePage extends StatelessWidget {
  const SecondePage({Key key, this.title}) : super(key: key);
  final title;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    String value = "2";
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(title),
      ),
      body: new Center(
        //这是一个IOS风格材质的按钮，需要导入cupertino文件才能引用
          child: new Container(
             child: new Column(
                 mainAxisSize: MainAxisSize.max,
                 children: <Widget>[
                   new Row(
                      children: <Widget>[
                        new Text("大类       "),
                        new Center(
                          child: new DropdownButton(
                            items: <DropdownMenuItem<String>>[
                              DropdownMenuItem(child: Text("进货",style: TextStyle(color: value=="1"?Colors.red:Colors.grey),),value: "1",),
                              DropdownMenuItem(child: Text("订单出库",style: TextStyle(color: value=="2"?Colors.red:Colors.grey),),value: "2",),
                              DropdownMenuItem(child: Text("订单剩余",style: TextStyle(color: value=="3"?Colors.red:Colors.grey),),value: "3",),
                            ],
                            hint:new Text("提示信息"),// 当没有初始值时显示
                            onChanged: (selectValue){//选中后的回调
                              // setState(() {
                              //   value = selectValue;
                              // });
                            },
                            value: value,// 设置初始值，要与列表中的value是相同的
                            elevation: 10,//设置阴影
                            style: new TextStyle(//设置文本框里面文字的样式
                                color: Colors.blue,
                                fontSize: 15
                            ),
                            iconSize: 30,//设置三角标icon的大小
                            underline: Container(height: 1,color: Colors.blue,),// 下划线

                          ),
                        ),
                      ]
                   ),
                   new Row(
                       children: <Widget>[
                         new Text("小类       "),
                         new Center(
                           child: new DropdownButton(
                             items: <DropdownMenuItem<String>>[
                               DropdownMenuItem(child: Text("进货",style: TextStyle(color: value=="1"?Colors.red:Colors.grey),),value: "1",),
                               DropdownMenuItem(child: Text("订单出库",style: TextStyle(color: value=="2"?Colors.red:Colors.grey),),value: "2",),
                               DropdownMenuItem(child: Text("订单剩余",style: TextStyle(color: value=="3"?Colors.red:Colors.grey),),value: "3",),
                             ],
                             hint:new Text("提示信息"),// 当没有初始值时显示
                             onChanged: (selectValue){//选中后的回调
                               // setState(() {
                               //   value = selectValue;
                               // });
                             },
                             value: value,// 设置初始值，要与列表中的value是相同的
                             elevation: 10,//设置阴影
                             style: new TextStyle(//设置文本框里面文字的样式
                                 color: Colors.blue,
                                 fontSize: 15
                             ),
                             iconSize: 30,//设置三角标icon的大小
                             underline: Container(height: 1,color: Colors.blue,),// 下划线

                           ),
                         ),
                       ]
                   ),
                   new Row(
                     children: <Widget>[
                       new Text("货号       "),
                       new Center(
                         child: new DropdownButton(
                           items: <DropdownMenuItem<String>>[
                             DropdownMenuItem(child: Text("a1",style: TextStyle(color: value=="1"?Colors.red:Colors.grey),),value: "1",),
                             DropdownMenuItem(child: Text("a2",style: TextStyle(color: value=="2"?Colors.red:Colors.grey),),value: "2",),
                             DropdownMenuItem(child: Text("b2",style: TextStyle(color: value=="3"?Colors.red:Colors.grey),),value: "3",),
                             DropdownMenuItem(child: Text("c1",style: TextStyle(color: value=="4"?Colors.red:Colors.grey),),value: "4",),
                           ],
                           hint:new Text("提示信息"),// 当没有初始值时显示
                           onChanged: (selectValue){//选中后的回调
                            // setState(() {
                            //   value = selectValue;
                            // });
                           },
                           value: value,// 设置初始值，要与列表中的value是相同的
                           elevation: 10,//设置阴影
                           style: new TextStyle(//设置文本框里面文字的样式
                               color: Colors.blue,
                               fontSize: 15
                           ),
                           iconSize: 30,//设置三角标icon的大小
                           underline: Container(height: 1,color: Colors.blue,),// 下划线

                         ),
                       ),
                     ],

                   ),
                   new Row(
                       children: <Widget>[
                         new Text("类型       "),
                         new Center(
                           child: new DropdownButton(
                             items: <DropdownMenuItem<String>>[
                               DropdownMenuItem(child: Text("进货",style: TextStyle(color: value=="1"?Colors.red:Colors.grey),),value: "1",),
                               DropdownMenuItem(child: Text("订单出库",style: TextStyle(color: value=="2"?Colors.red:Colors.grey),),value: "2",),
                               DropdownMenuItem(child: Text("订单剩余",style: TextStyle(color: value=="3"?Colors.red:Colors.grey),),value: "3",),
                             ],
                             hint:new Text("提示信息"),// 当没有初始值时显示
                             onChanged: (selectValue){//选中后的回调
                               // setState(() {
                               //   value = selectValue;
                               // });
                             },
                             value: value,// 设置初始值，要与列表中的value是相同的
                             elevation: 10,//设置阴影
                             style: new TextStyle(//设置文本框里面文字的样式
                                 color: Colors.blue,
                                 fontSize: 15
                             ),
                             iconSize: 30,//设置三角标icon的大小
                             underline: Container(height: 1,color: Colors.blue,),// 下划线

                           ),
                         ),
                       ]
                   ),
                   new Row(
                       children: <Widget>[
                         new Text("数目       "),
                         new Expanded(
                             child: new TextField(
                                 inputFormatters:[WhitelistingTextInputFormatter.digitsOnly],//只允许输入数字
                               //相当于Android属性hint
                                 decoration: new InputDecoration(
                                   hintText: "数目",
                                 )))
                       ]
                   ),
                   new Row(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     mainAxisAlignment: MainAxisAlignment.spaceAround,
                     children: <Widget>[
                                 new RaisedButton(
                                   onPressed: () {
                                     Navigator.pop(context);
                                   },
                                   child: Text("确认"),
                                 ),
                             new RaisedButton(
                               onPressed: () {
                                 Navigator.pop(context);
                               },
                               child: Text("取消"),
                             )

                     ]
                   ),
                 ]
             )

          )
      ),
    );
  }
}