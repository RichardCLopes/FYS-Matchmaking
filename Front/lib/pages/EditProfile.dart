// ignore: file_names, unnecessary_import
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fys/builders.dart';
import 'package:fys/http.dart';
import 'package:fys/main.dart';
import 'package:fys/pages/SignUpPage.dart';
import 'package:fys/pages/gameList.dart';

double spaceHeight = 10;

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  Widget _mainpart = CircularProgressIndicator();

  @override
  void initState() {
    loadProfile();
  }

  void loadProfile() {
    getUser().then((value) {
      setState(() {
        //placeholder
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              stops: [0.2, 0.6, 0.8],
              // ignore: prefer_const_literals_to_create_immutables
              colors: <Color>[
                Color.fromARGB(255, 40, 7, 49),
                Color.fromARGB(255, 59, 14, 59),
                Color.fromARGB(255, 94, 28, 94)
              ],
            ),
          ),
          padding: EdgeInsets.only(top: 30, left: 20, right: 20),
          child: ListView(
            children: [
              Text(
                'Perfil',
                style: TextStyle(
                  fontFamily: 'alagard',
                  color: Colors.white,
                  fontSize: 60,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: spaceHeight,
              ),
              Container(
                  padding: EdgeInsets.only(top: 10, left: 30, right: 30),
                  child: TextFormField(
                    keyboardType: TextInputType.url,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color.fromARGB(255, 34, 34, 34),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 51, 225, 255), width: 1),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      hintText: 'Foto',
                      hintStyle: TextStyle(
                          color: Color.fromARGB(255, 189, 189, 189),
                          fontSize: 30,
                          fontFamily: 'alagard'),
                      contentPadding: EdgeInsets.all(12.0),
                    ),
                    style: TextStyle(
                      fontSize: 25,
                      color: Color.fromARGB(255, 189, 189, 189),
                    ),
                  )),
              SizedBox(
                height: spaceHeight,
              ),
              Container(
                height: 70,
                padding: EdgeInsets.only(top: 10, left: 30, right: 30),
                child: ElevatedButton(
                  onPressed: () => PushScreen(context, gameSelectPage()),
                  child: Text(
                    "selecionar jogos",
                    style: TextStyle(
                        color: Color.fromARGB(255, 40, 6, 49),
                        fontSize: 27,
                        fontFamily: 'alagard'),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 51, 225, 255),
                    side: BorderSide(
                        color: Color.fromARGB(255, 40, 6, 49), width: 2),
                    // ignore: unnecessary_new
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(5.0),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: spaceHeight,
              ),
              Container(
                  padding: EdgeInsets.only(top: 10, left: 30, right: 30),
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color.fromARGB(255, 34, 34, 34),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 51, 225, 255), width: 1),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      hintText: 'Infomação adicional',
                      hintStyle: TextStyle(
                          color: Color.fromARGB(255, 189, 189, 189),
                          fontSize: 27,
                          fontFamily: 'alagard'),
                      contentPadding: EdgeInsets.all(12.0),
                    ),
                    style: TextStyle(
                      fontSize: 23,
                      color: Color.fromARGB(255, 189, 189, 189),
                    ),
                  )),
              SizedBox(
                height: spaceHeight,
              ),
              Container(
                  padding: EdgeInsets.only(top: 10, left: 30, right: 30),
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color.fromARGB(255, 34, 34, 34),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 51, 225, 255), width: 1),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      hintText: 'Localidade (opcional)',
                      hintStyle: TextStyle(
                          color: Color.fromARGB(255, 189, 189, 189),
                          fontSize: 25,
                          fontFamily: 'alagard'),
                      contentPadding: EdgeInsets.all(12.0),
                    ),
                    style: TextStyle(
                      fontSize: 22,
                      color: Color.fromARGB(255, 189, 189, 189),
                    ),
                  )),
              SizedBox(
                height: spaceHeight * 2,
              ),
              Container(
                height: 55,
                padding:
                    EdgeInsets.only(top: 0, left: 70, right: 70, bottom: 0),
                // ignore: unnecessary_new
                child: SizedBox.expand(
                  child: ElevatedButton(
                    child: Text(
                      "E D I T A R",
                      style: TextStyle(
                          fontFamily: 'alagard',
                          color: Color.fromARGB(255, 224, 224, 224),
                          fontSize: 20),
                      textAlign: TextAlign.left,
                    ),
                    onPressed: () => SwitchScreen(context,
                        MySignUpPage()), //trocar para a função de log in
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
              SizedBox(
                height: spaceHeight,
              ),
              Container(
                height: 55,
                padding:
                    EdgeInsets.only(top: 0, left: 85, right: 85, bottom: 0),
                // ignore: unnecessary_new
                child: SizedBox.expand(
                  child: ElevatedButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: <Widget>[
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          "V O L T A R",
                          style: TextStyle(
                              fontFamily: 'alagard',
                              color: Color.fromARGB(255, 40, 6, 49),
                              fontSize: 20),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 51, 225, 255),
                      side: BorderSide(
                          color: Color.fromARGB(255, 40, 6, 49), width: 2),
                      // ignore: unnecessary_new
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(5.0),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
