import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:fys/http.dart';

class Game {
  final String id;
  final String name;
  bool isChecked;

  Game({required this.id, required this.name, this.isChecked = false});
}

class gameSelectPage extends StatefulWidget {
  const gameSelectPage({Key? key}) : super(key: key);

  @override
  State<gameSelectPage> createState() => _gameSelectPageState();
}

class _gameSelectPageState extends State<gameSelectPage> {
  Widget _mainpart = CircularProgressIndicator();

  List<Game> gamelist = [];
  List<String> newGameList = [];
  @override
  void initState() {
    loadGames();
  }

  void loadGames() async {
    await getGames().then((value) {
      for (var game in value) {
        gamelist.add(Game(
            id: game[0],
            name: game[1],
            isChecked: userJogosID.contains(game[0])));
      }
      setState(() {
        _mainpart = ListView(children: GameListWidget(gamelist));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0x44000000),
          title: Text(
            "selecione jogos",
            style: TextStyle(fontSize: 20, color: Colors.yellow),
          ),
          actions: <Widget>[
            IconButton(
                onPressed: () {
                  for (var game in gamelist) {
                    if (userJogosID.contains(game.id))
                      game.isChecked = true;
                    else
                      game.isChecked = false;
                  }
                  setState(() {
                    _mainpart = ListView(children: GameListWidget(gamelist));
                  });
                },
                icon: Icon(Icons.restore)),
            IconButton(
                onPressed: () {
                  for (var game in gamelist) {
                    if (game.isChecked) newGameList.add(game.id);
                  }
                  UpdateUserGames(newGameList).then((value) {
                    if (value == 200) Navigator.pop(context);
                  });
                },
                icon: Icon(Icons.check))
          ],
        ),
        body: _mainpart);
  }

  List<Widget> GameListWidget(List<Game> gamelist) {
    var widgetlist = <Widget>[];
    for (int I = 0; I < gamelist.length; I++) {
      widgetlist.add(Container(
        child: Row(children: [
          Checkbox(
              checkColor: Colors.yellow,
              value: gamelist[I].isChecked,
              onChanged: (bool? value) {
                setState(() {
                  gamelist[I].isChecked = value!;
                  _mainpart = ListView(children: GameListWidget(gamelist));
                });
              }),
          Text(gamelist[I].name,
              style: TextStyle(
                fontSize: 25,
                color: Colors.white,
              ))
        ]),
      ));
    }

    return widgetlist;
  }
}
