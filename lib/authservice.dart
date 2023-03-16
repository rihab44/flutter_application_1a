import 'package:flutter_application_1a/ajoututulisateur.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthService {
   static const String apiUrl = 'http://192.168.1.195:3000/adduser';
static Future<http.Response> adduser(user User ) async {
print(User.tojson());
    var response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(User.tojson()),
    );
    print("response");
    print(response);
    if (response.statusCode == 201) {
      return response;
    } else {
      throw Exception('Impossible d\'ajouter le produit');
    }
  }
}

  

