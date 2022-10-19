import 'dart:ui';
import 'package:flutter/material.dart';

class ConnectionsPage extends StatelessWidget {
  const ConnectionsPage({Key? key}) : super(key: key);

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
                leading: Image.asset(
                  "assets/images/placeholder.png",
                  fit: BoxFit.scaleDown,
                ),
                title: Text(
                  "DISCORD",
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
                leading: Image.asset(
                  "assets/images/placeholder.png",
                  fit: BoxFit.scaleDown,
                ),
                title: Text(
                  "STEAM",
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
                leading: Image.asset(
                  "assets/images/placeholder.png",
                  fit: BoxFit.scaleDown,
                ),
                title: Text(
                  "RIOT",
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
                leading: Image.asset(
                  "assets/images/placeholder.png",
                  fit: BoxFit.scaleDown,
                ),
                title: Text(
                  "PLAYSTATION",
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
                leading: Image.asset(
                  "assets/images/placeholder.png",
                  fit: BoxFit.scaleDown,
                ),
                title: Text(
                  "XBOX",
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
