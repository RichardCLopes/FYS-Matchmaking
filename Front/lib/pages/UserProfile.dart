import 'dart:ui';
import 'package:age_calculator/age_calculator.dart';
import 'package:flutter/material.dart';
import 'package:fys/http.dart';

final double spaceHeight = 10;

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

Widget profile(User user) {
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
                child: Image.asset(user.picture, fit: BoxFit.scaleDown)),
          ),
          Expanded(
            flex: 3,
            child: Text(
              user.name + ", " + user.age,
              style: TextStyle(
                fontFamily: 'alagard',
                color: Colors.yellow,
                fontSize: 26,
              ),
            ),
          ),
        ]),
      ),
      Container(
        margin: EdgeInsets.symmetric(vertical: spaceHeight),
        child: Row(
          children: [
            Icon(
              Icons.computer,
              color: Colors.yellow,
            ),
            Container(
              width: 300,
              child: Text(
                user.plataforms,
                style: TextStyle(
                  fontFamily: 'alagard',
                  color: Colors.yellow,
                  fontSize: 22,
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
                fontSize: 24,
              ),
            ),
            Text(
              user.bio,
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
  Widget _mainpart = CircularProgressIndicator();

  @override
  void initState() {
    loadUser();
  }

  void loadUser() {
    getOtherUser(id).then((value) {
      final age = AgeCalculator.age(DateTime.parse(value[2])).years;
      String plataformas = "n/a";
      if (!value[3].isEmpty) {
        plataformas = '';
        for (int I = 0; I < value[3].length; I++) {
          plataformas += value[3][I];
          if (I != value[3].length - 1) plataformas += ", ";
        }
      }
      String bio = "n/a";
      if (value[4] != null) bio = value[4];

      String jogos = "n/a";
      if (!value[5].isEmpty) {
        jogos = '';
        for (int I = 0; I < value[5].length; I++) {
          jogos += value[5][I];
          if (I != value[5].length - 1) jogos += ", ";
        }
      }
      final user = User(
          id: value[0],
          name: value[1],
          age: age.toString(),
          plataforms: plataformas,
          bio: bio,
          games: jogos);
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
        actions: [],
      ),
      body: Container(
        alignment: Alignment.center,
        child: _mainpart,
      ),
    );
  }
}
