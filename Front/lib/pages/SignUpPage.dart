import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fys/builders.dart';
import 'package:fys/main.dart';
import 'package:fys/pages/homepage.dart';
import 'package:fys/pages/ShootNPick.dart';
import 'package:fys/pages/EditProfile.dart';
// ignore: unused_import
import 'package:flutter_picker/flutter_picker.dart';

double spaceHeight = 10;

class MySignUpPage extends StatefulWidget {
  const MySignUpPage({Key? key}) : super(key: key);

  @override
  State<MySignUpPage> createState() => _MySignUpPageState();
}

class _MySignUpPageState extends State<MySignUpPage> {
  DateTime date = DateTime.now();
  TextEditingController username = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();
  TextEditingController confirmPassword = new TextEditingController();
  TextEditingController birthdate = new TextEditingController();

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
                'Criar Conta',
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
              SizedBox(
                height: spaceHeight,
              ),
              Container(
                  padding: EdgeInsets.only(top: 10, left: 30, right: 30),
                  child: TextFormField(
                    controller: username,
                    keyboardType: TextInputType.name,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color.fromARGB(255, 34, 34, 34),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 51, 225, 255), width: 1),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      hintText: 'Nome',
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
              Container(
                  padding: EdgeInsets.only(top: 10, left: 30, right: 30),
                  child: TextFormField(
                    controller: email,
                    keyboardType: TextInputType.emailAddress,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color.fromARGB(255, 34, 34, 34),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 51, 225, 255), width: 1),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      hintText: 'e-mail',
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
                  padding: EdgeInsets.only(top: 10, left: 30, right: 30),
                  child: TextFormField(
                    controller: password,
                    keyboardType: TextInputType.visiblePassword,
                    textAlign: TextAlign.center,
                    obscureText: true,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color.fromARGB(255, 34, 34, 34),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 51, 225, 255), width: 1),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      hintText: 'Password',
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
                  padding: EdgeInsets.only(top: 10, left: 30, right: 30),
                  child: TextFormField(
                    controller: confirmPassword,
                    keyboardType: TextInputType.visiblePassword,
                    textAlign: TextAlign.center,
                    obscureText: true,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color.fromARGB(255, 34, 34, 34),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 51, 225, 255), width: 1),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      hintText: 'Confirm Password',
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
                  padding: EdgeInsets.only(top: 10, left: 30, right: 30),
                  child: TextFormField(
                    controller: birthdate,
                    keyboardType: TextInputType.datetime,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color.fromARGB(255, 34, 34, 34),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 51, 225, 255), width: 1),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      hintText: 'data de nascimento',
                      hintStyle: TextStyle(
                          color: Color.fromARGB(255, 189, 189, 189),
                          fontSize: 25,
                          fontFamily: 'alagard'),
                      contentPadding: EdgeInsets.all(12.0),
                    ),
                    style: TextStyle(
                      fontSize: 25,
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: <Widget>[
                        Text(
                          "C O M P L E T E",
                          style: TextStyle(
                              fontFamily: 'alagard',
                              color: Color.fromARGB(255, 224, 224, 224),
                              fontSize: 20),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                    onPressed: () => SignUpAttempt(),
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
                          "C A N C E L",
                          style: TextStyle(
                              fontFamily: 'alagard',
                              color: Color.fromARGB(255, 40, 6, 49),
                              fontSize: 20),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                    onPressed: () => SwitchScreen(context, MyHomePage()),
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

  void SignUpAttempt() {
    //check if 18 years old
    //check if passsword matches confirm password
    //check with server if information is valid
    //then:
    SwitchScreen(context, ShootnPickPage());
    PushScreen(context, EditProfilePage());
  }
}
