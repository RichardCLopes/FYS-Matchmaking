import 'dart:ui';
import 'dart:convert';
import 'dart:typed_data';
import 'package:age_calculator/age_calculator.dart';
import 'package:flutter/material.dart';
import 'package:fys/builders.dart';
import 'package:fys/http.dart';
import 'package:fys/pages/Messages.dart';
import 'package:fys/pages/ShootNPick.dart';
import 'package:fys/pages/reportPage.dart';

final double spaceHeight = 10;

class User {
  final String id;
  final String name;
  final String age;
  final String picture;
  final String plataforms;
  final String bio;
  final String games;
  final String local;

  const User({
    required this.id,
    required this.name,
    required this.age,
    required this.picture,
    required this.plataforms,
    required this.bio,
    required this.games,
    required this.local,
  });
}

Widget profile(User user) {
  Widget userfoto;
  if (user.picture.isNotEmpty) {
    Uint8List bytesImage;
    String imgString = user.picture;
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
  return Container(
    width: 360,
    alignment: Alignment.center,
    child: ListView(children: [
      Container(
        margin: EdgeInsets.symmetric(vertical: spaceHeight),
        child: Row(children: [
          Expanded(
            flex: 1,
            child: Container(
                height: 55,
                width: 55,
                margin: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 1)),
                child: userfoto),
          ),
          Expanded(
            flex: 3,
            child: Container(
              alignment: Alignment.centerLeft,
              child: Column(
                children: [
                  Text(
                    user.name,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontFamily: 'alagard',
                      color: Colors.yellow,
                      fontSize: 28,
                    ),
                  ),
                  Text(
                    "idade: " + user.age,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontFamily: 'alagard',
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
      Row(
        children: [
          Icon(
            Icons.place,
            color: Colors.yellow,
            size: 30,
          ),
          Container(
            child: Text(
              user.local,
              textAlign: TextAlign.left,
              style: TextStyle(
                fontFamily: 'alagard',
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
        ],
      ),
      Container(
        margin: EdgeInsets.symmetric(vertical: spaceHeight),
        child: Row(
          children: [
            Icon(
              Icons.computer,
              color: Colors.yellow,
              size: 32,
            ),
            Container(
              alignment: Alignment.bottomLeft,
              width: 300,
              child: Text(
                user.plataforms,
                style: TextStyle(
                  fontFamily: 'alagard',
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
          ],
        ),
      ),
      Container(
        margin: EdgeInsets.symmetric(vertical: spaceHeight),
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
                fontSize: 26,
              ),
            ),
            Text(
              user.bio,
              textAlign: TextAlign.left,
              style: TextStyle(
                fontFamily: 'alagard',
                color: Colors.white,
                fontSize: 22,
              ),
            ),
          ],
        ),
      ),
      Container(
        margin: EdgeInsets.symmetric(vertical: spaceHeight),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Jogos:",
              style: TextStyle(
                fontFamily: 'alagard',
                color: Colors.yellow,
                fontSize: 26,
              ),
            ),
            Text(
              user.games,
              style: TextStyle(
                fontFamily: 'alagard',
                color: Colors.white,
                fontSize: 22,
              ),
            ),
          ],
        ),
      ),
    ]),
  );
}

class userProfilePage extends StatefulWidget {
  userProfilePage(this.id);
  final String id;

  @override
  State<userProfilePage> createState() => _userProfilePageState(id);
}

class _userProfilePageState extends State<userProfilePage> {
  _userProfilePageState(this.id);
  final String id;
  late User user;
  Widget _mainpart = CircularProgressIndicator();
  Widget button = Container();

  @override
  void initState() {
    loadUser();
  }

  void loadUser() async {
    final matches = await getMatches();
    for (var match in matches) {
      if (match[0] == id) {
        button = IconButton(
            onPressed: () {
              showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text('Remover usuário'),
                  content: Text(
                      'Tem certeza que deseja remover o usuario' + match[1]),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        removeMatch(id).then((value) {
                          if (value == 200)
                            SwitchScreen(context, MessagesPage());
                        });
                      },
                      child: const Text('Sim'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'OK'),
                      child: const Text('Não'),
                    ),
                  ],
                ),
              );
            },
            icon: Icon(Icons.remove));
        break;
      } else if (match == matches.last)
        button = IconButton(
            onPressed: () {
              sendMatch(id, true).then((value) {
                SwitchScreen(context, ShootnPickPage());
              });
            },
            icon: Icon(Icons.add));
    }
    getOtherUser(id).then((value) {
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
      String local = "n/a";
      if (value[6] != null && value[6] != "") local = value[6];
      String foto = "";
      if (value[7] != null && value[7].isNotEmpty) foto = value[7];
      user = User(
          id: value[0],
          name: value[1],
          age: age.toString(),
          plataforms: plataformas,
          picture: foto,
          bio: bio,
          games: jogos,
          local: local);
      setState(() {
        _mainpart = profile(user);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0x44000000),
        actions: [
          button,
          IconButton(
              onPressed: () => PushScreen(context, reportPage(id, user.name)),
              icon: Icon(Icons.report_problem))
        ],
      ),
      body: Container(
        alignment: Alignment.center,
        child: _mainpart,
      ),
    );
  }
}
