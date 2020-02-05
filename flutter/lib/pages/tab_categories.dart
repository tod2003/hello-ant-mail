

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'node.dart';

class CategoryTree extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CategoryTreeState();
  }
}

class CategoryTreeState extends State<CategoryTree> {
  List<Node> expand = new List();

  ///保存所有数据的List
  List<Node> list = new List();
  List<int> mark = new List();

  @override
  void initState() {
    buildNode();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        actions: <Widget> [
          IconButton(icon: Icon(Icons.refresh), onPressed: (){}),
          IconButton(icon: Icon(Icons.add), onPressed: (){}),
          IconButton(icon: Icon(Icons.delete), onPressed: (){}),
          IconButton(icon: Icon(Icons.edit), onPressed: (){}),
          IconButton(icon: Icon(Icons.search), onPressed: () {
          }),
        ]
      ),
      body: Container(
        child: Column(
          children: _buildNode(expand),
        ),
      ),
    );
  }

  ///构建元素
  List<Widget> _buildNode(List<Node> nodes) {
    print('buildNode:' + nodes.length.toString());
    List<Widget> widgets = List();
    if (nodes != null && nodes.length > 0) {
      for (Node node in nodes) {
        widgets.add(GestureDetector(
          child: ImageText(10.0 * node.depth, node.object.toString(),
              node.expand, node.isHasChildren),
          onTap: () {
            if (node.isHasChildren) {
              if (node.expand) {
                //之前是扩展状态，收起列表
                node.expand = false;
                _collect(node.nodeId);
              } else {
                //之前是收起状态，扩展列表
                node.expand = true;
                _expand(node.nodeId);
              }
              setState(() {});
            }
          },
        ));
      }
    }
    return widgets;
  }

  ///第一个节点的index
  int nodeId = 1;

  ///扩展机构树：id代表被点击的机构id
  /// 做法是遍历整个list列表，将直接挂在该机构下面的节点增加到一个临时列表中，
  ///然后将临时列表插入到被点击的机构下面
  void _expand(int id) {
    //保存到临时列表
    List<Node> tmp = new List();
    for (Node node in list) {
      if (node.fatherId == id) {
        tmp.add(node);
      }
    }
    //找到插入点
    int index = -1;
    int length = expand.length;
    for (int i = 0; i < length; i++) {
      if (id == expand[i].nodeId) {
        index = i + 1;
        break;
      }
    }
    //插入
    expand.insertAll(index, tmp);
  }
  ///收起机构树：id代表被点击的机构id
  /// 做法是遍历整个expand列表，将直接和间接挂在该机构下面的节点标记，
  ///将这些被标记节点删除即可，此处用到的是将没有被标记的节点加入到新的列表中
  void _collect(int id) {
    //清楚之前的标记
    mark.clear();
    //标记
    _mark(id);
    //重新对expand赋值
    List<Node> tmp = new List();
    for (Node node in expand) {
      if (mark.indexOf(node.nodeId) < 0) {
        tmp.add(node);
      } else {
        node.expand = false;
      }
    }
    expand.clear();
    expand.addAll(tmp);
    setState(() {});
  }
  ///标记，在收起机构树的时候用到
  void _mark(int id) {
    for (Node node in expand) {
      if (id == node.fatherId) {
        if (node.isHasChildren) {
          _mark(node.nodeId);
        }
        mark.add(node.nodeId);
      }
    }
  }
  void buildNode() {
    Node<String> node = new Node(false, 1, 1, 0, '地板', true);
    Node<String> node1 = new Node(false, 1, 2, 0, '胶', false);
    Node<String> node2 = new Node(false, 1, 3, 0, '木条', false);
    Node<String> node3 = new Node(false, 1, 4, 0, '钉子', false);

    Node<String> node4 = new Node(false, 3, 5, 1, '灰花', true);

    Node<String> node5 = new Node(false, 6, 6, 5, 'd1', false);
    expand.add(node);
    expand.add(node1);
    expand.add(node2);
    expand.add(node3);

    list.add(node);
    list.add(node1);
    list.add(node2);
    list.add(node3);
    list.add(node4);
    list.add(node5);

    print('创建数据：' + expand.length.toString());
  }
}

class ImageText extends StatelessWidget {
  double margin = 0;
  String str = '';
  bool isExpand = false;
  bool isHasChildren = false;

  ImageText(double margin, String str, bool isExpand, bool isHasChildren) {
    this.margin = margin;
    this.str = str;
    this.isExpand = isExpand;
    this.isHasChildren = isHasChildren;
    print('margin:' + margin.toString());
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(color: Colors.black12),
      width: double.infinity,
      height: 40,
      margin: EdgeInsets.only(left: margin),
      child: Row(
        children: <Widget>[
          Visibility(
            visible: isHasChildren,
            child: Image.asset(isExpand
                ? 'assets/images/test.png'
                : 'assets/images/test.png'),
          ),
          Text(
            str,
            style: TextStyle(fontSize: 17),
          )
        ],
      ),
    );
  }
}
