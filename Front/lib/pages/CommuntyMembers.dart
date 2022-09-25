import 'dart:ffi';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fys/builders.dart';
import 'package:fys/main.dart';

class Member {
  final int id;
  final String name;
  final String picture;

  const Member({required this.id, required this.name, required this.picture});
}

List<Widget> MemberWidgetList(BuildContext context, List<Member> MemberList) {
  var widgetList = <Widget>[];
  int j = 0;
  var rowList = <Widget>[];
  for (int I = 0; I < MemberList.length; I++) {
    rowList.add(
      Container(
        height: 160,
        width: 100,
        margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
        decoration:
            BoxDecoration(border: Border.all(color: Colors.white, width: 1)),
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(primary: Color(0x00000000)),
          child: Stack(
            children: [
              Image.asset(
                MemberList[I].picture,
                fit: BoxFit.scaleDown,
              ),
              Container(
                alignment: Alignment.bottomCenter,
                child: Text(
                  MemberList[I].name,
                  style: TextStyle(
                    fontFamily: 'alagard',
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
    j++;
    if (j >= 3) {
      widgetList.add(Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: rowList,
      ));
      j = 0;
      rowList = <Widget>[];
    }
  }
  return widgetList;
}

class MemberListPage extends StatefulWidget {
  const MemberListPage({Key? key}) : super(key: key);

  @override
  State<MemberListPage> createState() => _MemberListPageState();
}

class _MemberListPageState extends State<MemberListPage> {
  Widget _mainpart = CircularProgressIndicator();

  @override
  void initState() {
    LoadMembers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0x44000000),
        title: Text("Membros"),
      ),
      body: Container(child: _mainpart),
    );
  }

  void LoadMembers() {
    print("carregando membros");
    //placeholder
    Member c =
        Member(id: 1, name: "bob", picture: "assets/images/placeholder.png");
    Member d =
        Member(id: 2, name: "todd", picture: "assets/images/placeholder.png");
    Member e =
        Member(id: 3, name: "chad", picture: "assets/images/placeholder.png");
    final memberList = <Member>[c, d, e, c, d, e];
    //placeholder
    print("membros carregados");
    setState(() {
      _mainpart = ListView(children: MemberWidgetList(context, memberList));
    });
  }
}
