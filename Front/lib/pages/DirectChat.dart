import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fys/builders.dart';

class chatPage extends StatefulWidget {
  chatPage(this.id);
  final int id;
  @override
  State<chatPage> createState() => _chatPageState(this.id);
}

class _chatPageState extends State<chatPage> {
  _chatPageState(this.id);

  final int id;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      centerTitle: true,
      title:
          Text("id: " + id.toString()), //pegar o nome atravez do server pelo ID
    ));
  }
}