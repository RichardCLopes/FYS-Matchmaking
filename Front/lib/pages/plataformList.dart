import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:fys/http.dart';

class Platform {
  final String id;
  final String name;
  bool isChecked;

  Platform({required this.id, required this.name, this.isChecked = false});
}

class plataformSelectPage extends StatefulWidget {
  const plataformSelectPage({Key? key}) : super(key: key);

  @override
  State<plataformSelectPage> createState() => _plataformSelectPageState();
}

class _plataformSelectPageState extends State<plataformSelectPage> {
  Widget _mainpart = CircularProgressIndicator();
  List<Platform> platlist = [];
  List<String> newPlatList = [];
  @override
  void initState() {
    loadPlats();
  }

  void loadPlats() async {
    await getAllPlatforms().then((value) {
      for (var game in value) {
        platlist.add(Platform(
            id: game[0],
            name: game[1],
            isChecked: userPlatsID.contains(game[0])));
      }
      setState(() {
        _mainpart = ListView(children: PlatListWidget(platlist));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("selecione jogos"),
          actions: <Widget>[
            IconButton(
                onPressed: () {
                  for (var plat in platlist) {
                    if (userPlatsID.contains(plat.id))
                      plat.isChecked = true;
                    else
                      plat.isChecked = false;
                  }
                  setState(() {
                    _mainpart = ListView(children: PlatListWidget(platlist));
                  });
                },
                icon: Icon(Icons.restore)),
            IconButton(
                onPressed: () {
                  for (var plat in platlist) {
                    if (plat.isChecked) newPlatList.add(plat.id);
                  }
                  UpdateUserPlatforms(newPlatList).then((value) {
                    if (value == 200) Navigator.pop(context);
                  });
                },
                icon: Icon(Icons.check))
          ],
        ),
        body: _mainpart);
  }

  List<Widget> PlatListWidget(List<Platform> platlist) {
    var widgetlist = <Widget>[];
    for (int I = 0; I < platlist.length; I++) {
      widgetlist.add(Container(
        child: Row(children: [
          Checkbox(
              checkColor: Colors.white,
              value: platlist[I].isChecked,
              onChanged: (bool? value) {
                setState(() {
                  platlist[I].isChecked = value!;
                  _mainpart = ListView(children: PlatListWidget(platlist));
                });
              }),
          Text(platlist[I].name,
              style: TextStyle(
                fontSize: 25,
                color: Color.fromARGB(255, 189, 189, 189),
              ))
        ]),
      ));
    }

    return widgetlist;
  }
}
