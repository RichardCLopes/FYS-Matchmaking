import 'dart:ui';
import 'package:fys/builders.dart';
import 'package:flutter/material.dart';
import 'package:fys/pages/notifications.dart';

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
                  "CONTA",
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
                  "NOTIFICAÇÕES",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'alagard',
                    color: Colors.white,
                    fontSize: 46,
                  ),
                ),
                onTap: () => PushScreen(context, NotificationPage()),
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
                  "PREMIUM",
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
                  "PRIVACIDADE",
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
                  Icons.dashboard_customize,
                  size: 50,
                  color: Colors.white,
                ),
                title: Text(
                  "APARENCIA",
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
        ],
      ),
    );
  }
}
