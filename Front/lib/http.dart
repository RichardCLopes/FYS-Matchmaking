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
    await getUser();
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
  }
  return response.statusCode;
}

Future<List<dynamic>> getUser() async {
  List<dynamic> userInfo = [];
  userJogosID = [];
  userCommsID = [];
  userPlatsID = [];
  final response = await http.get(Uri.parse(ip + "usuarios/" + userID),
      headers: {HttpHeaders.authorizationHeader: 'bearer ' + token});
  if (response.statusCode == 200) {
    final info = jsonDecode(response.body);
    userInfo = [info["nome"], info["localidade"], info["bio"]];
    print("body:" + userInfo.toString());
    for (var game in info["jogos"]) userJogosID.add(game['_id']);
    for (var comm in info["comunidades"]) userCommsID.add(comm);
    for (var plat in info["plataformas"]) userPlatsID.add(plat["_id"]);
  } else {
    print("erro code:" + response.statusCode.toString());
  }
  return userInfo;
}

Future<List<dynamic>> getOtherUser(String id) async {
  List<dynamic> userInfo = [id];
  final response = await http.get(Uri.parse(ip + "usuarios/" + id),
      headers: {HttpHeaders.authorizationHeader: 'bearer ' + token});
  if (response.statusCode == 200) {
    final info = jsonDecode(response.body);
    userInfo = [
      info["_id"],
      info["nome"],
      info["dataNascimento"],
      info["plataformas"],
      info["bio"],
      info["jogos"],
      info["localidade"]
    ];
    print("body:" + userInfo.toString());
  } else {
    print("erro code:" + response.statusCode.toString());
  }
  return userInfo;
}

Future<List<dynamic>> getMatchCandidate() async {
  List<dynamic> match = [];
  final response = await http.post(Uri.parse(ip + "matching-proximo"),
      headers: {
        HttpHeaders.authorizationHeader: 'bearer ' + token,
        "Content-type": "application/json"
      },
      body: jsonEncode(<String, dynamic>{"usuarioBase": userID}));
  final matchinfo = json.decode(response.body);
  print("matchinfo: " + matchinfo.toString());
  if (response.statusCode == 200) {
    match = [
      matchinfo['_id'],
      matchinfo['nome'],
      matchinfo["dataNascimento"],
      matchinfo["plataformas"],
      matchinfo["bio"],
      matchinfo["jogos"]
    ];
  }
  return match;
}

Future<List<dynamic>> sendMatch(String id, bool accepted) async {
  List<dynamic> newUserInfo = [];
  final response = await http.post(Uri.parse(ip + "matching-proximo"),
      headers: {
        HttpHeaders.authorizationHeader: 'bearer ' + token,
        "Content-type": "application/json"
      },
      body: jsonEncode(<String, dynamic>{
        "usuarioBase": userID,
        "usuarioChecado": id,
        "resposta": accepted,
      }));
  final matchinfo = json.decode(response.body);
  print("matchinfo: " + matchinfo.toString());
  if (response.statusCode == 200) {
    newUserInfo = [
      matchinfo['_id'],
      matchinfo['nome'],
      matchinfo["dataNascimento"],
      matchinfo["plataformas"],
      matchinfo["bio"],
      matchinfo["jogos"],
    ];
  }
  return newUserInfo;
}

Future<int> removeMatch(String id) async {
  final response = await http.delete(Uri.parse(ip + "matching/" + userID),
      headers: {
        HttpHeaders.authorizationHeader: 'bearer ' + token,
        "Content-type": "application/json"
      },
      body: jsonEncode(<String, dynamic>{"usuarioRemovido": id}));
  print("code: " + response.statusCode.toString());
  print(response.body.toString());

  return response.statusCode;
}

Future<List<dynamic>> getMatches() async {
  List<dynamic> matches = [];
  final response = await http.get(Uri.parse(ip + "usuarios/" + userID),
      headers: {HttpHeaders.authorizationHeader: 'bearer ' + token});

  if (response.statusCode == 200) {
    for (var match in jsonDecode(response.body)["matches"]) {
      matches.add(await getOtherUser(match));
    }
  }
  return matches;
}

Future<int> UpdateUser(String nome, String local, String bio) async {
  final response = await http.put(Uri.parse(ip + "usuarios/" + userID),
      headers: {
        HttpHeaders.authorizationHeader: 'bearer ' + token,
        "Content-type": "application/json"
      },
      body: jsonEncode(<String, dynamic>{
        "nome": nome,
        "localidade": local,
        "bio": bio,
      }));
  return response.statusCode;
}

Future<int> UpdateUserGames(List<String> newJogosID) async {
  final response = await http.put(Uri.parse(ip + "usuarios/" + userID),
      headers: {
        HttpHeaders.authorizationHeader: 'bearer ' + token,
        "Content-type": "application/json"
      },
      body: jsonEncode(<String, dynamic>{"jogos": newJogosID}));
  if (response.statusCode == 200) {
    print("jogos do usuário atualizados");
    userJogosID = newJogosID;
  }
  return response.statusCode;
}

Future<int> UpdateUserPlatforms(List<String> newPlatsID) async {
  final response = await http.put(Uri.parse(ip + "usuarios/" + userID),
      headers: {
        HttpHeaders.authorizationHeader: 'bearer ' + token,
        "Content-type": "application/json"
      },
      body: jsonEncode(<String, dynamic>{"plataformas": newPlatsID}));
  if (response.statusCode == 200) {
    print("plataformas do usuário atualizados");
    userPlatsID = newPlatsID;
  }
  return response.statusCode;
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

Future<List<dynamic>> getCommMembers(String id) async {
  List<dynamic> members = [];
  final response = await http.get(Uri.parse(ip + "comunidades/" + id),
      headers: {HttpHeaders.authorizationHeader: 'bearer ' + token});
  if (response.statusCode == 200) {
    final info = jsonDecode(response.body);
    for (var membID in info["membros"]) {
      if (membID != userID) {
        var memberInfo = await getOtherUser(membID);
        members.add(memberInfo);
      }
    }
  }

  return members;
}

Future<List<dynamic>> getCommTopics(String id) async {
  List<dynamic> topics = [];
  final response = await http.get(Uri.parse(ip + "comunidades/" + id),
      headers: {HttpHeaders.authorizationHeader: 'bearer ' + token});
  if (response.statusCode == 200) {
    final topicsID = jsonDecode(response.body)["topicos"];
    for (var topic in topicsID) {
      topics.add(await getTopic(topic));
    }
  }
  print("topics: " + topics.toString());
  return topics;
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

Future<List<dynamic>> getTopic(String id) async {
  List<dynamic> topicInfo = [id];
  final response = await http.get(Uri.parse(ip + "topicos/" + id),
      headers: {HttpHeaders.authorizationHeader: 'bearer ' + token});
  if (response.statusCode == 200)
    topicInfo.add(jsonDecode(response.body)["nome"]);

  return topicInfo;
}

Future<int> JoinCommunity(String id) async {
  if (userCommsID.contains(id) == false) userCommsID.add(id);
  final response =
      await http.put(Uri.parse(ip + "usuarios-comunidade/" + userID),
          headers: {
            HttpHeaders.authorizationHeader: 'bearer ' + token,
            "Content-type": "application/json"
          },
          body: jsonEncode(<String, dynamic>{"comunidade": id}));
  if (response.statusCode != 200) userCommsID.remove(id);

  return response.statusCode;
}

Future<int> LeaveCommunity(String id) async {
  userCommsID.remove(id);
  final response =
      await http.delete(Uri.parse(ip + "usuarios-comunidade/" + userID),
          headers: {
            HttpHeaders.authorizationHeader: 'bearer ' + token,
            "Content-type": "application/json"
          },
          body: jsonEncode(<String, dynamic>{"comunidade": id}));

  if (response.statusCode != 200) userCommsID.add(id);
  return response.statusCode;
}

Future<int> ReportUser(String id, String reason) async {
  final response = await http.post(Uri.parse(ip + "denunciados"),
      headers: {
        HttpHeaders.authorizationHeader: 'bearer ' + token,
        "Content-type": "application/json"
      },
      body: jsonEncode(<String, dynamic>{
        "denunciado": id,
        "denunciador": userID,
        "motivo": reason
      }));
  print("response: " + response.body.toString());

  return response.statusCode;
}

void Logout() {
  token = '';
  userID = '';
  userJogosID = [];
  userCommsID = [];
  userPlatsID = [];
  print("logout feito com sucesso");
}
