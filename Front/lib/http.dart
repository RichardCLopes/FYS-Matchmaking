import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';

String token =
    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYzMjNhMWM0YWZhOTIwNTYyYzFmNTY0MSIsIm5vbWUiOiJ0ZXN0ZU5vbWUiLCJpYXQiOjE2NjM2MTM5MjJ9.3obJ_NUlTmHi2RkDNbMJ0TTJp_CK3iHBZ-ot9FNgaRY";
String userID = "";

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

void Logout() {
  token = '';
  userID = '';
  print("logout feito com sucesso");
}
