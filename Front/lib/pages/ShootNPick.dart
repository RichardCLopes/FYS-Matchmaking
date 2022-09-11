import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fys/builders.dart';
import 'package:fys/main.dart';
import 'package:fys/pages/Comunities.dart';
import 'package:fys/pages/Messages.dart';

double buttonWidth = 135;
double buttonHeigth = 50;
double fontsize = 17;

class User {
  final String name;
  final int age;
  final String picture;
  final String plataforms;
  final String bio;
  final String games;

  const User({
    required this.name,
    required this.age,
    this.picture = "assets/images/placeholder.png",
    this.plataforms = "n/a",
    this.bio = "n/a",
    this.games = "n/a",
  });
}

Widget Card(User user) {
  return Material(
    type: MaterialType.transparency,
    child: Container(
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 40, 6, 49),
          borderRadius: BorderRadius.all(Radius.circular(20)),
          border:
              Border.all(color: Color.fromARGB(255, 51, 225, 255), width: 2)),
      height: 440,
      width: 250,
      child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
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
                  child: Image.asset(user.picture, fit: BoxFit.scaleDown)),
            ),
            Expanded(
              flex: 2,
              child: Text(
                user.name + ", " + user.age.toString(),
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
                user.plataforms,
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
            mainAxisAlignment: MainAxisAlignment.start,
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
                user.bio,
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
            mainAxisAlignment: MainAxisAlignment.start,
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
                user.games,
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
  Widget _mainPart = CircularProgressIndicator();

  late User currentUser, nextUser;

  @override
  void initState() {
    loadCards();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0x44000000),
        leading: IconButton(
            onPressed: (() => PushScreen(context, SideMenuScreen())),
            icon: Icon(Icons.menu)),
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
              child: _mainPart),
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
                      onPressed: () {
                        updatecards();
                        rejectUser();
                      },
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
                      onPressed: () {
                        updatecards();
                        acceptUser();
                      },
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

  @override
  void loadCards() {
    print("carregando cards");
    //placeholder =========================================================
    currentUser = new User(
        name: "Bobbers",
        age: 20,
        plataforms: "PC, XBOX",
        bio:
            "minhas mains: aiaia, sii, di, sidiisid. Meu rank: 412. qualquer informaçao extra, sei la",
        games: "Overwatch, League of Legends, Fortnite");
    nextUser = new User(name: "Chad", age: 42);
    //placeholder =========================================================
    //get user -> currentUser
    //get user -> nextUser
    print("cards carregados");
    setState(() {
      _mainPart = Draggable(
        axis: Axis.horizontal,
        child: Card(currentUser),
        feedback: Card(currentUser),
        childWhenDragging: Card(nextUser),
        onDragEnd: (drag) {
          updatecards();
          if (drag.velocity.pixelsPerSecond.dx < 0) {
            rejectUser();
          } else {
            acceptUser();
          }
        },
      );
    });
  }

  void updatecards() {
    //current user = next user
    //next user = get user
    //update server
    print("current = new, new = get user");
  }

  void acceptUser() {
    print("accept!");
  }

  void rejectUser() {
    print("reject!");
  }
}
