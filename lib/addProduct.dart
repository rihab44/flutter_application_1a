
import 'package:flutter_application_1a/ajoututulisateur.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'model.dart';
class productservice {
  static const String apiUrl = 'http://192.168.1.195:8000/addproduct';

  static Future<http.Response> addProduct(produit Produit) async {
    print(Produit.tojson());
    var response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(Produit.tojson()),
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
