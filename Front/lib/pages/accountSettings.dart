import 'dart:ui';
import 'package:fys/builders.dart';
import 'package:flutter/material.dart';
import 'package:fys/pages/Settings.dart';

class accountSettingsPage extends StatefulWidget {
  const accountSettingsPage({super.key});

  @override
  State<accountSettingsPage> createState() => _accountSettingsPageState();
}

class _accountSettingsPageState extends State<accountSettingsPage> {
  TextEditingController email = TextEditingController();
  TextEditingController senha = TextEditingController();
  bool isEditingEmail = false;

  @override
  void initState() {
    loadUser();
  }

  void loadUser() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0x44000000),
      ),
      body: Container(
        child: ListView(
          children: [
            Container(
                padding: EdgeInsets.only(top: 10, left: 10, right: 30),
                child: Column(
                  children: [
                    Text(
                      "E-Mail:",
                      style: TextStyle(
                          color: Color.fromARGB(255, 189, 189, 189),
                          fontSize: 24,
                          fontFamily: 'alagard'),
                    ),
                    TextFormField(
                      enabled: isEditingEmail,
                      controller: email,
                      keyboardType: TextInputType.text,
                      textAlign: TextAlign.left,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color.fromARGB(255, 34, 34, 34),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 51, 225, 255),
                              width: 1),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        hintText: 'e-mail',
                        hintStyle: TextStyle(
                          fontSize: 21,
                          color: Color.fromARGB(255, 189, 189, 189),
                        ),
                        contentPadding: EdgeInsets.all(12.0),
                      ),
                      style: TextStyle(
                        fontSize: 22,
                        color: Color.fromARGB(255, 189, 189, 189),
                      ),
                    ),
                    Checkbox(
                      value: isEditingEmail,
                      onChanged: (value) {
                        setState(() {
                          isEditingEmail = value!;
                        });
                      },
                    )
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
