import 'dart:ui';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fys/builders.dart';
import 'package:fys/http.dart';
import 'package:fys/pages/CommunityChat.dart';
import 'package:fys/pages/CommunityTopics.dart';
import 'package:fys/pages/CommuntyMembers.dart';
import 'package:fys/pages/Comunities.dart';

import 'dart:typed_data';

double fontsize = 17;

class CommunityMainPage extends StatefulWidget {
  CommunityMainPage(this.id, this.nome, this.foto);
  final String id;
  final String nome;
  final String foto;

  @override
  State<CommunityMainPage> createState() =>
      _CommunityMainPageState(id, nome, foto);
}

class _CommunityMainPageState extends State<CommunityMainPage> {
  _CommunityMainPageState(this.id, this.nome, this.foto);
  final String id;
  final String nome;
  final String foto;

  Widget _mainPart = CircularProgressIndicator();

  @override
  void initState() {
    loadCommunity();
  }

  void loadCommunity() {
    Widget commFoto;
    print("comunidade carregada");
    if (foto.isNotEmpty) {
      Uint8List bytesImage;
      String imgString = foto;
      bytesImage = Base64Decoder().convert(imgString.substring(22));
      commFoto = Image.memory(
        bytesImage,
        fit: BoxFit.fill,
      );
    } else {
      commFoto = Image.asset(
        "assets/images/placeholder.png",
        fit: BoxFit.scaleDown,
      );
    }
    setState(() {
      _mainPart = Container(
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 0),
              alignment: Alignment.center,
              child: commFoto,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 0, vertical: 2),
              alignment: Alignment.bottomCenter,
              child: Text(
                nome,
                style: TextStyle(
                  backgroundColor: Color(0xff000000),
                  fontFamily: 'alagard',
                  color: Colors.white,
                  fontSize: 32,
                ),
              ),
            )
          ],
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Color(0x44000000),
        leading: IconButton(
            onPressed: (() => Navigator.pop(context)),
            icon: Icon(Icons.arrow_back)),
        actions: [
          IconButton(
              onPressed: () {
                showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: const Text('Sair da comunidade'),
                    content: const Text(
                        'Tem certeza que deseja sair da comunidade?'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          LeaveCommunity(id).then((value) {
                            if (value == 200) print("saiu da comunidade");
                            SwitchScreen(context, ComunitiesPage());
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
              icon: Icon(Icons.exit_to_app))
        ],
      ),
      body: Container(
          child: Column(
        children: [
          Expanded(flex: 7, child: _mainPart),
          Expanded(
              flex: 4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 1, horizontal: 0),
                      child: ElevatedButton(
                        child: Text(
                          "Membros",
                          style: TextStyle(
                              fontFamily: 'alagard',
                              color: Color.fromARGB(255, 224, 224, 224),
                              fontSize: fontsize),
                          textAlign: TextAlign.center,
                        ),
                        onPressed: () =>
                            PushScreen(context, MemberListPage(id)),
                        style: ElevatedButton.styleFrom(
                          primary: Color.fromARGB(255, 40, 6, 49),
                          side: BorderSide(
                              color: Color.fromARGB(255, 51, 225, 255),
                              width: 1),
                          // ignore: unnecessary_new
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 1, horizontal: 0),
                      child: ElevatedButton(
                        child: Text(
                          "Tópicos",
                          style: TextStyle(
                              fontFamily: 'alagard',
                              color: Color.fromARGB(255, 224, 224, 224),
                              fontSize: fontsize),
                          textAlign: TextAlign.center,
                        ),
                        onPressed: () => PushScreen(context, topicListPage(id)),
                        style: ElevatedButton.styleFrom(
                          primary: Color.fromARGB(255, 40, 6, 49),
                          side: BorderSide(
                              color: Color.fromARGB(255, 51, 225, 255),
                              width: 1),
                          // ignore: unnecessary_new
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 1, horizontal: 0),
                      child: ElevatedButton(
                        child: Text(
                          "Chat",
                          style: TextStyle(
                              fontFamily: 'alagard',
                              color: Color.fromARGB(255, 224, 224, 224),
                              fontSize: fontsize),
                          textAlign: TextAlign.center,
                        ),
                        onPressed: () =>
                            PushScreen(context, CommunityChatPage()),
                        style: ElevatedButton.styleFrom(
                          primary: Color.fromARGB(255, 40, 6, 49),
                          side: BorderSide(
                              color: Color.fromARGB(255, 51, 225, 255),
                              width: 1),
                          // ignore: unnecessary_new
                        ),
                      ),
                    ),
                  ),
                ],
              ))
        ],
      )),
    );
  }
}
