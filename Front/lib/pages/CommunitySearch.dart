import 'dart:ui';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fys/builders.dart';
import 'package:fys/http.dart';
import 'package:fys/pages/Messages.dart';
import 'package:fys/pages/ShootNPick.dart';
import 'package:fys/pages/Comunities.dart';

import 'dart:typed_data';

double buttonWidth = 135;
double buttonHeigth = 50;
double fontsize = 17;

class Community {
  final String id;
  final String name;
  final String picture;

  const Community(
      {required this.id,
      required this.name,
      this.picture = "assets/images/placeholder.png"});
}

List<Widget> communityWidgetList(
    BuildContext context, List<Community> communityList) {
  var widgetList = <Widget>[];
  Widget commFoto;

  for (int I = 0; I < communityList.length; I++) {
    if (communityList[I].picture.isNotEmpty) {
      Uint8List bytesImage;
      String imgString = communityList[I].picture;
      bytesImage = Base64Decoder().convert(imgString.substring(22));

      commFoto = Image.memory(
        bytesImage,
        fit: BoxFit.scaleDown,
      );
    } else
      commFoto = Image.asset(
        "assets/images/placeholder.png",
        fit: BoxFit.scaleDown,
      );

    widgetList.add(Container(
      height: 140,
      margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
      decoration:
          BoxDecoration(border: Border.all(color: Colors.white, width: 1)),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: commFoto,
          ),
          Expanded(
            flex: 5,
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 0, horizontal: 5),
              child: Text(
                communityList[I].name,
                style: TextStyle(
                  fontFamily: 'alagard',
                  color: Colors.white,
                  fontSize: 30,
                ),
              ),
            ),
          ),
          Expanded(
              flex: 1,
              child: IconButton(
                  onPressed: () {
                    JoinCommunity(communityList[I].id).then((value) {
                      if (value == 200) {
                        SwitchScreen(context, ComunitiesPage());
                        print("joined community " + communityList[I].name);
                      }
                    });
                  },
                  icon: Icon(
                    Icons.add,
                    color: Colors.white,
                  )))
        ],
      ),
    ));
  }
  return widgetList;
}

class CommunitySearchPage extends StatefulWidget {
  const CommunitySearchPage({Key? key}) : super(key: key);

  @override
  State<CommunitySearchPage> createState() => _CommunitySearchPageState();
}

class _CommunitySearchPageState extends State<CommunitySearchPage> {
  Widget _mainPart = CircularProgressIndicator();
  TextEditingController search = TextEditingController();
  @override
  void initState() {
    loadCommunities();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: (() => Navigator.pop(context)),
            icon: Icon(Icons.arrow_back)),
        actions: <Widget>[IconButton(onPressed: () {}, icon: Icon(Icons.add))],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
              height: 550,
              child: Column(children: [
                Expanded(
                    flex: 1,
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Procurar comunidades:",
                        style: TextStyle(
                          fontFamily: 'alagard',
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    )),
                Expanded(
                    flex: 1,
                    child: TextFormField(
                      controller: search,
                      onEditingComplete: () {
                        loadCommunities();
                      },
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color.fromARGB(255, 34, 34, 34),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 51, 225, 255),
                              width: 1),
                          borderRadius: BorderRadius.circular(2.0),
                        ),
                      ),
                      style: TextStyle(
                        fontSize: 20,
                        color: Color.fromARGB(255, 189, 189, 189),
                      ),
                    )),
                Expanded(flex: 7, child: _mainPart)
              ]),
            ),
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
                              color: Color.fromARGB(255, 51, 225, 255),
                              width: 1),
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
                        onPressed: () =>
                            SwitchScreen(context, ShootnPickPage()),
                        style: ElevatedButton.styleFrom(
                          primary: Color.fromARGB(255, 40, 6, 49),
                          side: BorderSide(
                              color: Color.fromARGB(255, 51, 225, 255),
                              width: 1),
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
                              color: Color.fromARGB(255, 51, 225, 255),
                              width: 1),
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
        ),
      ),
    );
  }

  void loadCommunities() {
    List<Community> communityList = [];
    print("carregando comunidades");
    getAllCommunities().then((value) {
      setState(() {
        for (var comm in value) {
          if (search.text.isEmpty || comm["nome"].contains(search.text)) {
            String foto = "";
            if (comm["foto"] != null && comm["foto"].isNotEmpty)
              foto = comm["foto"];
            communityList.add(
                Community(id: comm["_id"], name: comm["nome"], picture: foto));
          }
        }

        _mainPart = ListView(
          children: communityWidgetList(context, communityList),
        );
      });
      print("comunidades carregadas");
    });
  }
}
