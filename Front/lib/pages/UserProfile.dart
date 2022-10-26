import 'dart:ui';
import 'package:flutter/material.dart';

class userProfilePage extends StatefulWidget {
  userProfilePage(this.id);
  final String id;

  @override
  State<userProfilePage> createState() => _userProfilePageState(id);
}

class _userProfilePageState extends State<userProfilePage> {
  _userProfilePageState(this.id);
  final String id;
  Widget _mainpart = CircularProgressIndicator();

  @override
  void initState() {}

  void loadUser() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: _mainpart,
      ),
    );
  }
}
