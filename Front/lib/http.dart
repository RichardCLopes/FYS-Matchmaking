import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';

final String ip = "http://10.0.2.2:3000/";

String token = "";
String userID = "";
List<String> userJogosID = [];
List<String> userCommsID = [];
List<String> userPlatsID = [];

Future<int> testServer() async {
  final response = await http.get(Uri.parse(ip + "usuarios"),
      headers: {HttpHeaders.authorizationHeader: 'bearer ' + token});
  print("status code " + response.statusCode.toString());
  if (response.statusCode == 200) {
    print("sucesso");
    print(jsonDecode(response.body)[2]['nome'].toString());
  } else {
    throw Exception("falha em carregar usuarios");
  }
  return response.statusCode;
}

Future<int> login(String email, String senha) async {
  final response = await http.post(Uri.parse(ip + "login"),
      headers: {"Content-type": "application/json"},
      body: jsonEncode(<String, dynamic>{
        'email': email,
        'senha': senha,
      }));
  if (response.statusCode == 204) {
    token = response.headers['authorization'].toString();
    userID = JwtDecoder.decode(token)['id'];
    getUser();
    print("token: " + token);
    print("userID: " + userID);
  }
  return response.statusCode;
}

Future<int> createAccount(
    String nome, String email, String senha, DateTime nascimento) async {
  final response = await http.post(Uri.parse(ip + "usuarios"),
      headers: {"Content-type": "application/json"},
      body: jsonEncode(<String, dynamic>{
        "nome": nome,
        "email": email,
        "senha": senha,
        "dataNascimento": nascimento.toString()
      }));
  if (response.statusCode == 201) {
    await login(email, senha);
    print("conta criada!");
    return response.statusCode;
  } else
    return response.statusCode;
}

Future<List<dynamic>> getUser() async {
  List<dynamic> userInfo = [];
  final response = await http.get(Uri.parse(ip + "usuarios/" + userID),
      headers: {HttpHeaders.authorizationHeader: 'bearer ' + token});
  if (response.statusCode == 200) {
    userInfo.add(jsonDecode(response.body));
    print("body:" + userInfo.toString());
    for (var game in jsonDecode(response.body)["jogos"]) userJogosID.add(game);
    for (var comm in jsonDecode(response.body)["comunidades"])
      userCommsID.add(comm);
    for (var plat in jsonDecode(response.body)["plataformas"])
      userPlatsID.add(plat);
  } else {
    print("erro code:" + response.statusCode.toString());
  }
  return userInfo;
}

Future<List<dynamic>> getGames() async {
  List<dynamic> gameList = [];
  final response = await http.get(Uri.parse(ip + "jogos/"),
      headers: {HttpHeaders.authorizationHeader: 'bearer ' + token});
  if (response.statusCode == 200) {
    for (var game in jsonDecode(response.body)) {
      gameList.add([game['_id'], game['nome']]);
    }
    print(gameList.toString());
    print("sucesso");
  }

  return gameList;
}

Future<List<dynamic>> getAllPlatforms() async {
  List<dynamic> platList = [];
  final response = await http.get(Uri.parse(ip + "plataformas/"),
      headers: {HttpHeaders.authorizationHeader: 'bearer ' + token});
  if (response.statusCode == 200) {
    for (var game in jsonDecode(response.body)) {
      platList.add([game['_id'], game['nome']]);
    }
    print(platList.toString());
    print("sucesso");
  }

  return platList;
}

Future<List<dynamic>> getCommunity(String id) async {
  List<dynamic> commInfo = [];
  var comm;
  final response = await http.get(Uri.parse(ip + "comunidades/" + id),
      headers: {HttpHeaders.authorizationHeader: 'bearer ' + token});
  if (response.statusCode == 200) {
    comm = jsonDecode(response.body);
    commInfo = <String>[comm["_id"], comm["nome"], comm["foto"]];
    print(commInfo.toString());
  }
  return commInfo;
}

Future<List<dynamic>> getAllCommunities() async {
  List<dynamic> comms = [];
  final response = await http.get(Uri.parse(ip + "comunidades/"),
      headers: {HttpHeaders.authorizationHeader: 'bearer ' + token});
  if (response.statusCode == 200) {
    for (var comm in jsonDecode(response.body)) {
      if (!userCommsID.contains(comm["_id"])) comms.add(comm);
    }
  }
  return comms;
}

void Logout() {
  token = '';
  userID = '';
  userJogosID = [];
  userCommsID = [];
  userPlatsID = [];
  print("logout feito com sucesso");
}
