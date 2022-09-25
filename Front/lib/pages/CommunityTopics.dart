import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fys/builders.dart';
import 'package:fys/main.dart';
import 'package:fys/pages/TopicChat.dart';

class Topic {
  final int id;
  final String name;

  const Topic({required this.id, required this.name});
}

List<Widget> TopicWidgetList(context, List<Topic> TopicList) {
  var widgetList = <Widget>[];
  for (int I = 0; I < TopicList.length; I++) {
    widgetList.add(
      Container(
          alignment: Alignment.center,
          height: 140,
          margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
          decoration: BoxDecoration(
            border:
                Border.all(color: Color.fromARGB(255, 51, 225, 255), width: 1),
            color: Color(0x44000000),
          ),
          child: ElevatedButton(
            onPressed: () => PushScreen(context, TopicChatPage(0)),
            child: Text(
              TopicList[I].name,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'alagard',
                color: Colors.white,
                fontSize: 36,
              ),
            ),
            style: ElevatedButton.styleFrom(
                minimumSize: Size.fromHeight(double.infinity),
                primary: Color(0x00000000)),
          )),
    );
  }
  return widgetList;
}

class topicListPage extends StatefulWidget {
  const topicListPage({Key? key}) : super(key: key);

  @override
  State<topicListPage> createState() => _topicListPageState();
}

class _topicListPageState extends State<topicListPage> {
  Widget _mainpart = CircularProgressIndicator();

  @override
  void initState() {
    LoadTopicos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0x44000000),
        centerTitle: true,
        title: Text("Tópicos"),
        actions: <Widget>[IconButton(onPressed: () {}, icon: Icon(Icons.add))],
      ),
      body: Container(child: _mainpart),
    );
  }

  void LoadTopicos() {
    print("carregando tópicos");
    //placeholder
    Topic c = Topic(id: 1, name: "não dá");
    Topic d = Topic(id: 2, name: "personagem favorito");
    Topic e = Topic(id: 3, name: "oferta de troca");
    final topicList = <Topic>[c, d, e];
    //placeholder
    print("tópicos carregados");
    setState(() {
      _mainpart = ListView(
        children: TopicWidgetList(context, topicList),
      );
    });
  }
}
