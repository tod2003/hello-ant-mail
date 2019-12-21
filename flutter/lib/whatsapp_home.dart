import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutterwhatsapp/pages/setting.dart';
import 'package:flutterwhatsapp/pages/camera_screen.dart';
import 'package:flutterwhatsapp/pages/users.dart';
import 'package:flutterwhatsapp/pages/status_screen.dart';
import 'package:flutterwhatsapp/pages/goods_table.dart';
import 'package:flutterwhatsapp/pages/details_table.dart';
import 'package:flutterwhatsapp/pages/bills_table.dart';
import 'package:flutterwhatsapp/pages/category_tree.dart';

class WhatsAppHome extends StatefulWidget {
  final List<CameraDescription> cameras;
  WhatsAppHome({this.cameras});

  @override
  _WhatsAppHomeState createState() => _WhatsAppHomeState();
}

class _WhatsAppHomeState extends State<WhatsAppHome>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  bool showFab = true;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(vsync: this, initialIndex: 1, length: 6);
    _tabController.addListener(() {
      if (_tabController.index == 1) {
        showFab = true;
      } else {
        showFab = false;
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("德国柯诺"),
        elevation: 0.7,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          tabs: <Widget>[
            //Tab(icon: Icon(Icons.camera_alt)),
            //Tab(text: "人员"),
            Tab(
              text: "人员",
            ),
            Tab(
              text: "设置",
            ),
            Tab(
              text: "订单",
            ),
            Tab(
              text: "库存",
            ),
            Tab(
              text: "明细",
            ),
            Tab(
              text: "类别",
            ),
          ],
        ),
        actions: <Widget>[
          Icon(Icons.search),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
          ),
          Icon(Icons.more_vert)
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          //CameraScreen(widget.cameras),
          Users(),
          //StatusScreen(),
          Setting(),
          BillsTable(),
          GoodsTable(),
          DetailsTable(),
          CategoryTree(),
        ],
      ),
      floatingActionButton: showFab
          ? FloatingActionButton(
              backgroundColor: Theme.of(context).accentColor,
              child: Icon(
                Icons.message,
                color: Colors.white,
              ),
              onPressed: () => print("open chats"),
            )
          : null,
    );
  }
}
