import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

String token =
    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYzMjNhMWM0YWZhOTIwNTYyYzFmNTY0MSIsIm5vbWUiOiJ0ZXN0ZU5vbWUiLCJpYXQiOjE2NjM2MTM5MjJ9.3obJ_NUlTmHi2RkDNbMJ0TTJp_CK3iHBZ-ot9FNgaRY";

void testServer() async {
  final response = await http.get(Uri.parse("http://10.0.2.2:3000/usuarios"),
      headers: {HttpHeaders.authorizationHeader: 'bearer ' + token});
  print("status code " + response.statusCode.toString());
  if (response.statusCode == 200) {
    print("sucesso");
    print(jsonDecode(response.body)[2]['nome'].toString());
  } else {
    throw Exception("falha em carregar usuarios");
  }
}
