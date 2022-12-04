import 'dart:ffi';
import 'dart:ui';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:fys/builders.dart';
import 'package:fys/http.dart';
import 'package:fys/main.dart';
import 'package:fys/pages/UserProfile.dart';

class Member {
  final String id;
  final String name;
  final String picture;

  const Member(
      {required this.id,
      required this.name,
      this.picture = "assets/images/placeholder.png"});
}

List<Widget> MemberWidgetList(BuildContext context, List<Member> MemberList) {
  var widgetList = <Widget>[];
  int j = 0;
  Widget userfoto;
  var rowList = <Widget>[];
  for (int I = 0; I < MemberList.length; I++) {
    if (MemberList[I].picture.isNotEmpty) {
      Uint8List bytesImage;
      String imgString = MemberList[I].picture;
      bytesImage = Base64Decoder().convert(imgString.substring(22));
      userfoto = Image.memory(
        bytesImage,
        fit: BoxFit.scaleDown,
      );
    } else {
      userfoto = Image.asset(
        "assets/images/placeholder.png",
        fit: BoxFit.scaleDown,
      );
    }
    rowList.add(
      Container(
        height: 150,
        width: 100,
        margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
        decoration:
            BoxDecoration(border: Border.all(color: Colors.white, width: 1)),
        child: ElevatedButton(
          onPressed: () {
            PushScreen(context, userProfilePage(MemberList[I].id));
          },
          style: ElevatedButton.styleFrom(primary: Color(0x00000000)),
          child: Stack(
            children: [
              userfoto,
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
    if (j >= 3 || I == MemberList.length - 1) {
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
  MemberListPage(this.id);
  final String id;

  @override
  State<MemberListPage> createState() => _MemberListPageState(id);
}

class _MemberListPageState extends State<MemberListPage> {
  _MemberListPageState(this.id);
  final String id;
  Widget _mainpart = CircularProgressIndicator();

  @override
  void initState() {
    LoadMembers();
  }

  void LoadMembers() {
    print("carregando membros");
    List<Member> memberList = [];

    getCommMembers(id).then((value) {
      for (var memb in value) {
        String foto = "";
        if (memb[7] != null && memb[7].isNotEmpty) foto = memb[7];
        memberList.add(Member(id: memb[0], name: memb[1], picture: foto));
      }
      setState(() {
        _mainpart = ListView(children: MemberWidgetList(context, memberList));
        print("membros carregados");
      });
    });
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
}
