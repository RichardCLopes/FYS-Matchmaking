import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fys/builders.dart';
import 'package:fys/main.dart';
import 'package:fys/pages/Comunities.dart';
import 'package:fys/pages/Messages.dart';

double buttonWidth = 135;
double buttonHeigth = 50;
double fontsize = 17;

Widget Card(String name, String picture) {
  return Material(
    type: MaterialType.transparency,
    child: Container(
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 40, 6, 49),
          borderRadius: BorderRadius.all(Radius.circular(20)),
          border:
              Border.all(color: Color.fromARGB(255, 51, 225, 255), width: 2)),
      height: 440,
      width: 250,
      child: Column(children: [
        Expanded(
          flex: 2,
          child: Row(children: [
            Expanded(
              flex: 1,
              child: Container(
                  height: 55,
                  margin: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 1)),
                  child: Image.asset(picture, fit: BoxFit.scaleDown)),
            ),
            Expanded(
              flex: 2,
              child: Text(
                name + ", 24",
                style: TextStyle(
                  fontFamily: 'alagard',
                  color: Colors.yellow,
                  fontSize: 26,
                ),
              ),
            ),
          ]),
        ),
        Expanded(
          flex: 1,
          child: Row(
            children: [
              Icon(
                Icons.computer,
                color: Colors.yellow,
              ),
              Text(
                "PC, XBOX",
                style: TextStyle(
                  fontFamily: 'alagard',
                  color: Colors.yellow,
                  fontSize: 25,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Bio: ",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontFamily: 'alagard',
                  color: Colors.yellow,
                  fontSize: 24,
                ),
              ),
              Text(
                "minhas mains: aiaia, sii, di, sidiisid. Meu rank: 412. qualquer informaçao extra, sei la",
                maxLines: 3,
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontFamily: 'alagard',
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Jogos:",
                style: TextStyle(
                  fontFamily: 'alagard',
                  color: Colors.yellow,
                  fontSize: 24,
                ),
              ),
              Text(
                "Overwatch, League of Legends, Fortnite",
                style: TextStyle(
                  fontFamily: 'alagard',
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
      ]),
    ),
  );
}

class ShootnPickPage extends StatefulWidget {
  const ShootnPickPage({Key? key}) : super(key: key);

  @override
  State<ShootnPickPage> createState() => _ShootnPickPageState();
}

class _ShootnPickPageState extends State<ShootnPickPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
            onPressed: (() => PushScreen(context, SideMenuScreen())),
            icon: Icon(Icons.menu)),
        title: Text('shoot pick'),
        actions: <Widget>[
          IconButton(
              onPressed: (() => PushScreen(context, UserProfileScreen())),
              icon: Icon(Icons.account_circle_outlined)),
        ],
      ),
      body: Container(
          child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            height: 460,
            child: Draggable(
              axis: Axis.horizontal,
              child: Card("bob", "assets/images/placeholder.png"),
              feedback: Card("bob", "assets/images/placeholder.png"),
              childWhenDragging: Card("todd", "assets/images/placeholder.png"),
              onDragEnd: (drag) {
                if (drag.velocity.pixelsPerSecond.dx < 0) {
                  print("left");
                } else {
                  print("right");
                }
              },
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  height: 75,
                  width: 75,
                  child: FloatingActionButton(
                      heroTag: null,
                      onPressed: () {},
                      child: Icon(Icons.cancel)),
                ),
                SizedBox(
                  height: 75,
                  width: 10,
                ),
                SizedBox(
                  height: 75,
                  width: 75,
                  child: FloatingActionButton(
                      heroTag: null,
                      onPressed: () {},
                      child: Icon(Icons.thumb_up)),
                ),
              ],
            ),
          ),
          Row(
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
                    onPressed: () => SwitchScreen(context, ComunitiesPage()),
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
          )
        ],
      )),
    );
  }
}
