import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fys/builders.dart';

class TopicChatPage extends StatefulWidget {
  TopicChatPage(this.id);
  final int id;
  @override
  State<TopicChatPage> createState() => _TopicChatPageState(id);
}

class _TopicChatPageState extends State<TopicChatPage> {
  _TopicChatPageState(this.id);
  final int id;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.close), onPressed: () {}),
        ],
        title: Text("chat do tópico"),
        backgroundColor: Color.fromARGB(255, 40, 6, 49),
      ),
      body: SafeArea(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(flex: 9, child: Container()),
              Expanded(
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0x44000000),
                    /* gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      stops: [0.2, 0.6, 0.8],
                      // ignore: prefer_const_literals_to_create_immutables
                      colors: <Color>[
                        Color.fromARGB(255, 40, 7, 49),
                        Color.fromARGB(255, 59, 14, 59),
                        Color.fromARGB(255, 94, 28, 94)
                      ],
                    ), */
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: TextField(
                          onChanged: (value) {},
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'send',
                          style: TextStyle(
                            fontFamily: 'alagard',
                            color: Color.fromARGB(255, 224, 224, 224),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ]),
      ),
    );
  }
}
