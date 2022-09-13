import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fys/builders.dart';

double fontsize = 17;

class CommunityMainPage extends StatefulWidget {
  CommunityMainPage(this.id);
  final int id;

  @override
  State<CommunityMainPage> createState() => _CommunityMainPageState(id);
}

class _CommunityMainPageState extends State<CommunityMainPage> {
  _CommunityMainPageState(this.id);
  final int id;

  Widget _mainPart = CircularProgressIndicator();

  @override
  void initState() {
    loadCommunity();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0x44000000),
        leading: IconButton(
            onPressed: (() => Navigator.pop(context)),
            icon: Icon(Icons.arrow_back)),
      ),
      body: Container(
          child: Column(
        children: [
          Expanded(flex: 6, child: _mainPart),
          Expanded(
              flex: 4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      child: Text(
                        "Membros",
                        style: TextStyle(
                            fontFamily: 'alagard',
                            color: Color.fromARGB(255, 224, 224, 224),
                            fontSize: fontsize),
                        textAlign: TextAlign.center,
                      ),
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(255, 40, 6, 49),
                        side: BorderSide(
                            color: Color.fromARGB(255, 51, 225, 255), width: 1),
                        // ignore: unnecessary_new
                      ),
                    ),
                  ),
                  Expanded(
                    child: ElevatedButton(
                      child: Text(
                        "Tópicos",
                        style: TextStyle(
                            fontFamily: 'alagard',
                            color: Color.fromARGB(255, 224, 224, 224),
                            fontSize: fontsize),
                        textAlign: TextAlign.center,
                      ),
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(255, 40, 6, 49),
                        side: BorderSide(
                            color: Color.fromARGB(255, 51, 225, 255), width: 1),
                        // ignore: unnecessary_new
                      ),
                    ),
                  ),
                  Expanded(
                    child: ElevatedButton(
                      child: Text(
                        "Chat",
                        style: TextStyle(
                            fontFamily: 'alagard',
                            color: Color.fromARGB(255, 224, 224, 224),
                            fontSize: fontsize),
                        textAlign: TextAlign.center,
                      ),
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(255, 40, 6, 49),
                        side: BorderSide(
                            color: Color.fromARGB(255, 51, 225, 255), width: 1),
                        // ignore: unnecessary_new
                      ),
                    ),
                  ),
                ],
              ))
        ],
      )),
    );
  }

  void loadCommunity() {
    print("carregando comunidade ID " + id.toString());
    //placeholder
    String nome = "lol", foto = "assets/images/placeholder.png";
    //placeholder
    print("comunidade carregada");
    setState(() {
      _mainPart = Container(
        child: Stack(
          children: [
            Container(
              alignment: Alignment.center,
              child: Image.asset(
                foto,
                fit: BoxFit.scaleDown,
              ),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              child: Text(
                nome,
                style: TextStyle(
                  fontFamily: 'alagard',
                  color: Colors.white,
                  fontSize: 30,
                ),
              ),
            )
          ],
        ),
      );
    });
  }
}
