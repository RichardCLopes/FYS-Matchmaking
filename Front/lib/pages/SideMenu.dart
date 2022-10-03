import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:fys/builders.dart';
import 'package:fys/http.dart';
import 'package:fys/main.dart';
import 'package:fys/pages/EditProfile.dart';
import 'package:fys/pages/homepage.dart';

class sideMenu extends StatelessWidget {
  const sideMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      child: Scaffold(
        appBar: AppBar(),
        body: Container(
            color: Color.fromARGB(255, 59, 14, 59),
            child: ListView(
              children: [
                ListTile(
                  leading: Icon(Icons.auto_awesome_motion),
                  title: Text("Conexões"),
                  onTap: () => PushScreen(context, ConectionsScreen()),
                ),
                ListTile(
                  leading: Icon(Icons.account_circle),
                  title: Text("Perfil"),
                  onTap: () => PushScreen(context, EditProfilePage()),
                ),
                ListTile(
                  leading: Icon(Icons.settings),
                  title: Text("Configurações"),
                  onTap: () => PushScreen(context, SettingsScreen()),
                ),
                ListTile(
                  leading: Icon(Icons.logout),
                  title: Text("Sair"),
                  onTap: () => logout(context),
                )
              ],
            )),
      ),
    );
  }

  void logout(BuildContext context) {
    Logout();
    SwitchScreen(context, MyHomePage());
  }
}
