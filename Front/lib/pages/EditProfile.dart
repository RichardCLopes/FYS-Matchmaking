// ignore: file_names, unnecessary_import
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fys/builders.dart';
import 'package:fys/http.dart';
import 'package:fys/main.dart';
import 'package:fys/pages/SignUpPage.dart';
import 'package:fys/pages/gameList.dart';
import 'package:fys/pages/plataformList.dart';

double spaceHeight = 10;

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  TextEditingController nome = new TextEditingController();
  TextEditingController bio = new TextEditingController();
  TextEditingController local = new TextEditingController();

  Widget _mainpart = CircularProgressIndicator();
  Widget editButton = FloatingActionButton(
    child: Icon(Icons.edit),
    onPressed: () {},
  );
  Widget topButton = Container();

  var previous;
  bool isEditing = false;

  bool changesMade() {
    if (previous[0] != nome.text ||
        previous[1] != local.text ||
        previous[2] != bio.text) return true;
    return false;
  }

  Widget edittingButton() {
    return FloatingActionButton(
      child: Icon(Icons.edit),
      onPressed: () {
        setState(() {
          isEditing = true;
          editButton = FloatingActionButton(
              child: Icon(Icons.restore),
              onPressed: () {
                setState(() {
                  revertChanges();
                });
              });
          topButton = IconButton(
              onPressed: () {
                if (!changesMade()) {
                  setState(() {
                    isEditing = false;
                    topButton = Container();
                    editButton = edittingButton();
                  });
                } else {
                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: const Text('Aplicar mudanças'),
                      content: const Text(
                          'Tem certeza que deseja aplicar as mudanças?'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            UpdateUser(nome.text, local.text, bio.text)
                                .then((value) {
                              if (value == 200) {
                                print("edição feita com sucesso");
                                setState(() {
                                  isEditing = false;
                                  topButton = Container();
                                  editButton = edittingButton();
                                });
                                previous = [nome.text, local.text, bio.text];
                              }
                              Navigator.pop(context, 'OK');
                            });
                          },
                          child: const Text('Sim'),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'OK'),
                          child: const Text('Não'),
                        ),
                      ],
                    ),
                  );
                }
              },
              icon: Icon(Icons.check));
        });
      },
    );
  }

  @override
  void initState() {
    loadProfile();
  }

  void loadProfile() {
    getUser().then((value) {
      setState(() {
        previous = value;
        nome.text = value[0];
        local.text = value[1];
        bio.text = value[2];
        editButton = edittingButton();
      });
    });
  }

  void revertChanges() {
    nome.text = previous[0];
    local.text = previous[1];
    bio.text = previous[2];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0x44000000),
        actions: <Widget>[topButton],
      ),
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
              Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: Container(
                        padding: EdgeInsets.only(left: 30),
                        height: 100,
                        width: 100,
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Image.asset(
                            "assets/images/placeholder.png",
                            fit: BoxFit.scaleDown,
                          ),
                          style: ElevatedButton.styleFrom(
                              primary: Color(0x00000000)),
                        ),
                      )),
                  Expanded(
                    flex: 2,
                    child: Container(
                        padding: EdgeInsets.only(top: 10, left: 10, right: 30),
                        child: Column(
                          children: [
                            Text(
                              "NOME:",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 189, 189, 189),
                                  fontSize: 24,
                                  fontFamily: 'alagard'),
                            ),
                            TextFormField(
                              enabled: isEditing,
                              controller: nome,
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
                                hintText: 'Nome',
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
                          ],
                        )),
                  ),
                ],
              ),
              SizedBox(
                height: spaceHeight,
              ),
              Container(
                  padding: EdgeInsets.only(top: 10, left: 30, right: 30),
                  child: Column(
                    children: [
                      Text(
                        "LOCAL:",
                        style: TextStyle(
                            color: Color.fromARGB(255, 189, 189, 189),
                            fontSize: 24,
                            fontFamily: 'alagard'),
                      ),
                      TextFormField(
                        controller: local,
                        enabled: isEditing,
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
                          hintText: 'ex: São Paulo, SP, Brasil',
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
                    ],
                  )),
              SizedBox(
                height: spaceHeight,
              ),
              Container(
                  padding: EdgeInsets.only(top: 10, left: 30, right: 30),
                  child: Column(
                    children: [
                      Text(
                        "BIO:",
                        style: TextStyle(
                            color: Color.fromARGB(255, 189, 189, 189),
                            fontSize: 24,
                            fontFamily: 'alagard'),
                      ),
                      TextFormField(
                        enabled: isEditing,
                        controller: bio,
                        keyboardType: TextInputType.multiline,
                        maxLength: 100,
                        maxLines: 4,
                        minLines: 3,
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
                          hintText: 'Escreva algo sobre você',
                          hintStyle: TextStyle(
                            fontSize: 21,
                            color: Color.fromARGB(255, 189, 189, 189),
                          ),
                          contentPadding: EdgeInsets.all(12.0),
                        ),
                        style: TextStyle(
                          fontSize: 21,
                          color: Color.fromARGB(255, 189, 189, 189),
                        ),
                      ),
                    ],
                  )),
              SizedBox(
                height: spaceHeight * 2,
              ),
              Container(
                height: 70,
                padding: EdgeInsets.only(top: 10, left: 30, right: 30),
                child: ElevatedButton(
                  onPressed: () {
                    if (isEditing) PushScreen(context, gameSelectPage());
                  },
                  child: Text(
                    "Jogos",
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
                height: 70,
                padding: EdgeInsets.only(top: 10, left: 30, right: 30),
                child: ElevatedButton(
                  onPressed: () {
                    if (isEditing) PushScreen(context, plataformSelectPage());
                  },
                  child: Text(
                    "Plataformas",
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
            ],
          )),
      floatingActionButton: editButton,
    );
  }
}
