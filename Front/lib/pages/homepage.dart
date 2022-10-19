// ignore_for_file: prefer_const_constructors, unnecessary_new, duplicate_ignore
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fys/builders.dart';
import 'package:fys/http.dart';
import 'package:fys/pages/ShootNPick.dart';
import 'package:fys/pages/SignUpPage.dart';

class MyHomePage extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();

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
          children: <Widget>[
            SizedBox(
              child: Image.asset("assets/images/logo.png"),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'FYS',
              style: TextStyle(
                fontFamily: 'alagard',
                color: Colors.white,
                fontSize: 60,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 10,
            ),
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
                    hintText: 'E-mail',
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
                padding: EdgeInsets.only(top: 20, left: 30, right: 30),
                child: TextFormField(
                  controller: password,
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
            SizedBox(height: 40),
            Container(
              height: 55,
              padding: EdgeInsets.only(top: 0, left: 70, right: 70, bottom: 0),
              // ignore: unnecessary_new
              child: SizedBox.expand(
                child: ElevatedButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: <Widget>[
                      Icon(
                        Icons.person,
                        color: Color.fromARGB(255, 224, 224, 224),
                        size: 40,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        "L O G I N",
                        style: TextStyle(
                            fontFamily: 'alagard',
                            color: Color.fromARGB(255, 224, 224, 224),
                            fontSize: 20),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                  onPressed: () {
                    if (email.text.length > 0 && password.text.length > 0) {
                      loginAttempt(email.text, password.text, context);
                    } else {
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text('Campos vazios'),
                          content: const Text('Preencha os campos'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'OK'),
                              child: const Text('OK'),
                            ),
                          ],
                        ),
                      );
                    }
                  }, //trocar para a função de log in
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
            SizedBox(height: 20),
            Container(
              height: 55,
              padding: EdgeInsets.only(top: 0, left: 85, right: 85, bottom: 0),
              // ignore: unnecessary_new
              child: SizedBox.expand(
                child: ElevatedButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: <Widget>[
                      Text(
                        "S I G N   U P",
                        style: TextStyle(
                            fontFamily: 'alagard',
                            color: Color.fromARGB(255, 40, 6, 49),
                            fontSize: 20),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                  onPressed: () => SwitchScreen(context,
                      MySignUpPage()), //trocar para função de criar conta
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
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 60,
                  width: 150,
                  child: ElevatedButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: <Widget>[
                        Image.asset(
                          'assets/images/google.png',
                          width: 30,
                        ),
                        SizedBox(
                          width: 6,
                        ),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            // ignore: prefer_const_literals_to_create_immutables
                            children: <Widget>[
                              Text(
                                "Sign in with",
                                style: TextStyle(
                                    fontFamily: 'alagard',
                                    color: Color.fromARGB(255, 224, 224, 224),
                                    fontSize: 12),
                                textAlign: TextAlign.left,
                              ),
                              Text(
                                "Google",
                                style: TextStyle(
                                    fontFamily: 'alagard',
                                    color: Color.fromARGB(255, 224, 224, 224),
                                    fontSize: 18),
                                textAlign: TextAlign.left,
                              ),
                            ]),
                      ],
                    ),
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 94, 28, 94),
                      side: BorderSide(
                          color: Color.fromARGB(255, 51, 225, 255), width: 1),
                      // ignore: unnecessary_new
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(5.0),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                SizedBox(
                  height: 60,
                  width: 150,
                  child: ElevatedButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: <Widget>[
                        Icon(
                          Icons.apple,
                          color: Color.fromARGB(255, 224, 224, 224),
                          size: 45,
                        ),
                        SizedBox(
                          width: 2,
                        ),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            // ignore: prefer_const_literals_to_create_immutables
                            children: <Widget>[
                              Text(
                                "Sign in with",
                                style: TextStyle(
                                    fontFamily: 'alagard',
                                    color: Color.fromARGB(255, 224, 224, 224),
                                    fontSize: 12),
                                textAlign: TextAlign.left,
                              ),
                              Text(
                                "App ID",
                                style: TextStyle(
                                    fontFamily: 'alagard',
                                    color: Color.fromARGB(255, 224, 224, 224),
                                    fontSize: 18),
                                textAlign: TextAlign.left,
                              ),
                            ]),
                      ],
                    ),
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 94, 28, 94),
                      side: BorderSide(
                          color: Color.fromARGB(255, 51, 225, 255), width: 1),
                      // ignore: unnecessary_new
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(5.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void loginAttempt(String email, String password, BuildContext context) {
    login(email, password).then((value) {
      print(value.toString());
      if (value == 204)
        SwitchScreen(context, ShootnPickPage());
      else if (value == 401) {
        showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('Usuário não encontrado'),
            content: const Text('Email ou senha incorretos'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'OK'),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    });
    //check with the server
    //if works:

    //else pop up
  }
}
