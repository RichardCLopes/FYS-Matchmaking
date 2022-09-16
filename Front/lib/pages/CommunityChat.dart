import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fys/builders.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';

class CommunityChatPage extends StatefulWidget {
  const CommunityChatPage({Key? key}) : super(key: key);

  @override
  State<CommunityChatPage> createState() => _CommunityChatPageState();
}

class _CommunityChatPageState extends State<CommunityChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("chat lol")),
    );
  }
}
