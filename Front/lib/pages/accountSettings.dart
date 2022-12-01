import 'dart:ui';
import 'package:fys/builders.dart';
import 'package:flutter/material.dart';
import 'package:fys/pages/Settings.dart';

class SettingsMainPage extends StatelessWidget {
  const SettingsMainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                border: Border(
                    top: BorderSide(width: 1, color: Colors.white),
                    bottom: BorderSide(width: 1, color: Colors.white))),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 0),
              child: ListTile(
                leading: Icon(
                  Icons.account_circle,
                  size: 50,
                  color: Colors.white,
                ),
                title: Text(
                  "E-MAIL",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'alagard',
                    color: Colors.white,
                    fontSize: 46,
                  ),
                ),
                onTap: () {},
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
                border: Border(
                    top: BorderSide(width: 1, color: Colors.white),
                    bottom: BorderSide(width: 1, color: Colors.white))),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 0),
              child: ListTile(
                leading: Icon(
                  Icons.notifications_active,
                  size: 50,
                  color: Colors.white,
                ),
                title: Text(
                  "SENHAS",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'alagard',
                    color: Colors.white,
                    fontSize: 46,
                  ),
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
                border: Border(
                    top: BorderSide(width: 1, color: Colors.white),
                    bottom: BorderSide(width: 1, color: Colors.white))),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 0),
              child: ListTile(
                leading: Icon(
                  Icons.workspace_premium,
                  size: 50,
                  color: Colors.white,
                ),
                title: Text(
                  "DATA",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'alagard',
                    color: Colors.white,
                    fontSize: 46,
                  ),
                ),
                onTap: () {},
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
                border: Border(
                    top: BorderSide(width: 1, color: Colors.white),
                    bottom: BorderSide(width: 1, color: Colors.white))),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 0),
              child: ListTile(
                leading: Icon(
                  Icons.lock,
                  size: 50,
                  color: Colors.white,
                ),
                title: Text(
                  "ID DE USUARIO",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'alagard',
                    color: Colors.white,
                    fontSize: 46,
                  ),
                ),
                onTap: () {},
              ),
            ),
          ),
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
      ),
    );
  }
}
