import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fys/builders.dart';
import 'package:fys/http.dart';
import 'package:fys/main.dart';
import 'package:fys/pages/TopicChat.dart';

class Topic {
  final String id;
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
  topicListPage(this.CommID);
  final String CommID;

  @override
  State<topicListPage> createState() => _topicListPageState(CommID);
}

class _topicListPageState extends State<topicListPage> {
  _topicListPageState(this.CommID);
  final String CommID;
  Widget _mainpart = CircularProgressIndicator();

  @override
  void initState() {
    LoadTopicos();
  }

  void LoadTopicos() {
    print("carregando tópicos");
    List<Topic> topicList = [];
    getCommTopics(CommID).then((value) {
      for (var topic in value) {
        topicList.add(Topic(id: topic[0], name: topic[1]));
      }
      setState(() {
        _mainpart = ListView(
          children: TopicWidgetList(context, topicList),
        );
      });
      print("tópicos carregados");
    });
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
}
