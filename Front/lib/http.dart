import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';

String token = "";
String userID = "";
List<String> userJogosID = [];

Future<int> testServer() async {
  final response = await http.get(Uri.parse("http://10.0.2.2:3000/usuarios"),
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
  final response = await http.post(Uri.parse("http://10.0.2.2:3000/login"),
      headers: {"Content-type": "application/json"},
      body: jsonEncode(<String, dynamic>{
        'email': email,
        'senha': senha,
      }));
  if (response.statusCode == 204) {
    token = response.headers['authorization'].toString();
    userID = JwtDecoder.decode(token)['id'];
    print("token: " + token);
    print("userID: " + userID);
  }
  return response.statusCode;
}

Future<int> createAccount(
    String nome, String email, String senha, DateTime nascimento) async {
  final response = await http.post(Uri.parse("http://10.0.2.2:3000/usuarios"),
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
  final response = await http.get(
      Uri.parse("http://10.0.2.2:3000/usuarios/" + userID),
      headers: {HttpHeaders.authorizationHeader: 'bearer ' + token});
  if (response.statusCode == 200) {
    //userInfo.add(response.body[]);
    print("body:" + jsonDecode(response.body).toString());
    for (var game in jsonDecode(response.body)["jogos"])
      userJogosID.add(game["_id"].toString());
    print("jogos do usuario:" + userJogosID.toString());
  } else {
    print("erro code:" + response.statusCode.toString());
  }
  return userInfo;
}

Future<List<dynamic>> getGames() async {
  List<dynamic> gameList = [];
  final response = await http.get(Uri.parse("http://10.0.2.2:3000/jogos/"),
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

void Logout() {
  token = '';
  userID = '';
  userJogosID = [];
  print("logout feito com sucesso");
}
