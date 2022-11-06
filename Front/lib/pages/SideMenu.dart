import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:fys/builders.dart';
import 'package:fys/http.dart';
import 'package:fys/main.dart';
import 'package:fys/pages/EditProfile.dart';
import 'package:fys/pages/homepage.dart';
import 'package:fys/pages/Connections.dart';
import 'package:fys/pages/Settings.dart';

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
                  leading: Icon(
                    Icons.auto_awesome_motion,
                    color: Colors.white,
                  ),
                  title: Text(
                    "Conexões",
                    style: TextStyle(
                      fontFamily: 'alagard',
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  onTap: () => PushScreen(context, ConnectionsPage()),
                ),
                ListTile(
                  leading: Icon(Icons.account_circle, color: Colors.white),
                  title: Text(
                    "Perfil",
                    style: TextStyle(
                      fontFamily: 'alagard',
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  onTap: () => PushScreen(context, EditProfilePage()),
                ),
                ListTile(
                  leading: Icon(Icons.settings, color: Colors.white),
                  title: Text(
                    "Configurações",
                    style: TextStyle(
                      fontFamily: 'alagard',
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  onTap: () => PushScreen(context, SettingsMainPage()),
                ),
                ListTile(
                  leading: Icon(Icons.logout, color: Colors.white),
                  title: Text(
                    "Sair",
                    style: TextStyle(
                      fontFamily: 'alagard',
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  onTap: () {
                    showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text('Desconectar'),
                        content:
                            const Text('Tem certeza que deseja desconectar?'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => logout(context),
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
