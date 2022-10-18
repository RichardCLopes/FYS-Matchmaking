import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fys/builders.dart';
import 'package:fys/main.dart';
import 'package:fys/pages/Messages.dart';
import 'package:fys/pages/ShootNPick.dart';
import 'package:fys/pages/CommunitySearch.dart';
import 'package:fys/pages/CommunityMain.dart';
import 'package:fys/pages/SideMenu.dart';
import 'package:fys/pages/EditProfile.dart';

double buttonWidth = 135;
double buttonHeigth = 50;
double fontsize = 17;

class Community {
  final int id;
  final String name;
  final String picture;

  const Community(
      {required this.id, required this.name, required this.picture});
}

List<Widget> communityWidgetList(
    BuildContext context, List<Community> communityList) {
  var widgetList = <Widget>[];
  int j = 0;
  var rowList = <Widget>[];
  for (int I = 0; I < communityList.length; I++) {
    rowList.add(
      Container(
        height: 160,
        width: 100,
        margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
        decoration:
            BoxDecoration(border: Border.all(color: Colors.white, width: 1)),
        child: ElevatedButton(
          onPressed: () =>
              PushScreen(context, CommunityMainPage(communityList[I].id)),
          style: ElevatedButton.styleFrom(primary: Color(0x00000000)),
          child: Stack(
            children: [
              Image.asset(
                communityList[I].picture,
                fit: BoxFit.scaleDown,
              ),
              Container(
                alignment: Alignment.bottomCenter,
                child: Text(
                  communityList[I].name,
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

class ComunitiesPage extends StatefulWidget {
  const ComunitiesPage({Key? key}) : super(key: key);

  @override
  State<ComunitiesPage> createState() => _ComunitiesPageState();
}

class _ComunitiesPageState extends State<ComunitiesPage> {
  Widget _mainPart = CircularProgressIndicator();

  @override
  void initState() {
    loadCommunities();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: sideMenu(),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0x44000000),
        title: IconButton(
            onPressed: () => PushScreen(context, CommunitySearchPage()),
            icon: Icon(Icons.add)),
        actions: <Widget>[
          IconButton(
              onPressed: (() => PushScreen(context, EditProfilePage())),
              icon: Icon(Icons.account_circle_outlined)),
        ],
      ),
      body: Container(
          child: Column(
        children: [
          Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              height: 550,
              child: _mainPart),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: buttonWidth,
                  height: buttonHeigth,
                  // ignore: unnecessary_new
                  child: SizedBox.expand(
                    child: ElevatedButton(
                      child: Text(
                        "Mensagens",
                        style: TextStyle(
                            fontFamily: 'alagard',
                            color: Color.fromARGB(255, 224, 224, 224),
                            fontSize: fontsize),
                        textAlign: TextAlign.left,
                      ),
                      onPressed: () => SwitchScreen(context, MessagesPage()),
                      style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(255, 40, 6, 49),
                        side: BorderSide(
                            color: Color.fromARGB(255, 51, 225, 255), width: 1),
                        // ignore: unnecessary_new
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(5.0),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: buttonWidth,
                  height: buttonHeigth,

                  // ignore: unnecessary_new
                  child: SizedBox.expand(
                    child: ElevatedButton(
                      child: Text(
                        "Shoot n Pick",
                        style: TextStyle(
                            fontFamily: 'alagard',
                            color: Color.fromARGB(255, 224, 224, 224),
                            fontSize: fontsize),
                        textAlign: TextAlign.left,
                      ),
                      onPressed: () => SwitchScreen(context, ShootnPickPage()),
                      style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(255, 40, 6, 49),
                        side: BorderSide(
                            color: Color.fromARGB(255, 51, 225, 255), width: 1),
                        // ignore: unnecessary_new
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(5.0),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: buttonWidth,
                  height: buttonHeigth,
                  // ignore: unnecessary_new
                  child: SizedBox.expand(
                    child: ElevatedButton(
                      child: Text(
                        "Comunidades",
                        style: TextStyle(
                            fontFamily: 'alagard',
                            color: Color.fromARGB(255, 224, 224, 224),
                            fontSize: fontsize),
                        textAlign: TextAlign.left,
                      ),
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(255, 40, 6, 49),
                        side: BorderSide(
                            color: Color.fromARGB(255, 51, 225, 255), width: 1),
                        // ignore: unnecessary_new
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(5.0),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      )),
    );
  }

  void loadCommunities() {
    print("carregando comunidades");
    //placeholder =========================================================
    Community c = new Community(
        id: 1, name: "yoyo", picture: "assets/images/placeholder.png");
    Community d = new Community(
        id: 2, name: "sus", picture: "assets/images/placeholder.png");
    Community e = new Community(
        id: 3, name: "booo", picture: "assets/images/placeholder.png");
    final communityList = <Community>[c, d, e, c, d, e, c, d, e, c, d, e];
    //placeholder =========================================================
    print("comunidades carregadas");
    setState(() {
      _mainPart = ListView(
        children: communityWidgetList(context, communityList),
      );
    });
  }
}
