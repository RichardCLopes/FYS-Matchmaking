import 'dart:ui';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fys/builders.dart';
import 'package:fys/http.dart';
import 'package:fys/main.dart';
import 'package:fys/pages/Comunities.dart';
import 'package:fys/pages/Messages.dart';
import 'package:fys/pages/SideMenu.dart';
import 'package:fys/pages/EditProfile.dart';
import 'package:fys/pages/UserProfile.dart';
import 'package:age_calculator/age_calculator.dart';

import 'dart:typed_data';

double buttonWidth = 135;
double buttonHeigth = 50;
double fontsize = 17;

class User {
  final String id;
  final String name;
  final String age;
  final String picture;
  final String plataforms;
  final String bio;
  final String games;

  const User({
    required this.id,
    required this.name,
    required this.age,
    this.picture = "assets/images/placeholder.png",
    required this.plataforms,
    required this.bio,
    required this.games,
  });
}

Widget Card(BuildContext context, User user) {
  Widget userfoto = Image.asset(
    "assets/images/placeholder.png",
    fit: BoxFit.scaleDown,
  );

  if (user.picture.isNotEmpty) {
    Uint8List bytesImage;
    String imgString = user.picture;
    bytesImage = Base64Decoder().convert(imgString.substring(22));
    userfoto = Image.memory(bytesImage);
  }

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
      child: Stack(
        children: [
          Container(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: Icon(
                  Icons.info,
                  size: 35,
                  color: Color.fromARGB(255, 51, 225, 255),
                ),
                onPressed: () => PushScreen(context, userProfilePage(user.id)),
              )),
          Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            Expanded(
              flex: 2,
              child: Row(children: [
                Expanded(
                  flex: 1,
                  child: Container(
                      height: 55,
                      margin:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 1)),
                      child: userfoto),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    user.name + ",\n" + user.age,
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
                  Container(
                    width: 200,
                    child: Text(
                      user.plataforms,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: 'alagard',
                        color: Colors.yellow,
                        fontSize: 24,
                      ),
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
                    overflow: TextOverflow.ellipsis,
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
                    maxLines: 3,
                    overflow: TextOverflow.fade,
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
        ],
      ),
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
  bool enableButtons = true;
  late User currentUser;

  @override
  void initState() {
    loadCards();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: sideMenu(),
      appBar: AppBar(
        backgroundColor: Color(0x44000000),
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
              padding: EdgeInsets.symmetric(vertical: 10),
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
                        if (enableButtons == true) {
                          sendMatch(currentUser.id, false).then((value) {
                            updatecards(value);
                            print("rejected");
                          });
                        }
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
                        if (enableButtons == true) {
                          sendMatch(currentUser.id, true).then((value) {
                            updatecards(value);
                            print("accepted");
                          });
                        }
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
    getMatchCandidate().then((value) {
      updatecards(value);
    });
  }

  void updatecards(value) {
    if (value.isEmpty) {
      setState(() {
        _mainPart = Text(
          "nenhum candidato válido",
          style: TextStyle(
              fontFamily: 'alagard',
              color: Color.fromARGB(255, 224, 224, 224),
              fontSize: fontsize),
        );
      });
      enableButtons = false;
    } else {
      final age = AgeCalculator.age(DateTime.parse(value[2])).years;
      String plataformas = "n/a";
      if (!value[3].isEmpty) {
        plataformas = '';
        for (int I = 0; I < value[3].length; I++) {
          plataformas += value[3][I]["nome"];
          if (I != value[3].length - 1) plataformas += ", ";
        }
      }
      String bio = "n/a";
      if (value[4] != null) bio = value[4];

      String jogos = "n/a";
      if (!value[5].isEmpty) {
        jogos = '';
        for (int I = 0; I < value[5].length; I++) {
          jogos += value[5][I]["nome"];
          if (I != value[5].length - 1) jogos += ", ";
        }
      }
      String foto = "";
      if (value[6] != null && value[6].isNotEmpty) foto = value[6];
      setState(() {
        currentUser = User(
            id: value[0],
            name: value[1],
            age: age.toString(),
            plataforms: plataformas,
            bio: bio,
            games: jogos,
            picture: foto);
        _mainPart = Container(
          alignment: Alignment.center,
          child: Stack(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DragTarget<String>(
                    builder: (context, candidateData, rejectedData) {
                      return Container(
                        height: 500,
                        width: 120,
                        // color: Colors.white,
                      );
                    },
                    onAccept: (String id) {
                      sendMatch(currentUser.id, false).then((value) {
                        updatecards(value);
                        print("rejected");
                      });
                    },
                  ),
                  DragTarget<String>(
                    builder: (context, candidateData, rejectedData) {
                      return Container(
                        height: 500,
                        width: 120,
                        // color: Colors.white,
                      );
                    },
                    onAccept: (String id) {
                      sendMatch(currentUser.id, true).then((value) {
                        updatecards(value);
                        print("accepted");
                      });
                    },
                  ),
                ],
              ),
              Container(
                alignment: Alignment.center,
                child: Draggable<String>(
                  axis: Axis.horizontal,
                  data: currentUser.id,
                  child: Card(context, currentUser),
                  feedback: Card(context, currentUser),
                  childWhenDragging: Container(
                    width: 250,
                  ),
                ),
              ),
            ],
          ),
        );
        enableButtons = true;
      });
    }
    print("card carregado");
  }
}
