import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fys/builders.dart';
import 'package:fys/pages/UserProfile.dart';

class chatPage extends StatefulWidget {
  chatPage(this.id);
  final String id;
  @override
  State<chatPage> createState() => _chatPageState(this.id);
}

class _chatPageState extends State<chatPage> {
  _chatPageState(this.id);

  final String id;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      backgroundColor: Color(0x44000000),
      actions: [
        IconButton(
          icon: Icon(
            Icons.account_circle,
            size: 35,
            color: Color.fromARGB(255, 51, 225, 255),
          ),
          onPressed: () => PushScreen(context, userProfilePage(id)),
        )
      ],
      centerTitle: true,
      title: Text(id), //pegar o nome atravez do server pelo ID
    ));
  }
}
