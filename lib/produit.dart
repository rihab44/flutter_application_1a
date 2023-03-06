import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'page.dart';

class Produit {
  String nom;
  double prix;
  double code;
  double stock;
  double criteredemesure;

  Produit({
    required this.nom,
    required this.prix,
    required this.code,
    required this.stock,
    required this.criteredemesure,
  });

  Map<String, dynamic> toJson() => {
        'nom': nom,
        'prix': prix,
        'code': code,
        'stock': stock,
        'criteredemesure': criteredemesure,
      };
}

class productservice {
  static const String apiUrl = 'http://127.0.0.1:8000/addproduct';

  static Future<http.Response> addProduct(Produit produit) async {
    print(produit.toJson());
    var response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(produit.toJson()),
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

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({Key? key}) : super(key: key);

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  var _formKey = GlobalKey<FormState>();
  var _nomController = TextEditingController();

  var _prixController = TextEditingController();
  var _codeController = TextEditingController();
  var _stockController = TextEditingController();
  var _criteredemesureController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ajoutproduit'),
        backgroundColor: Colors.purple,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nomController,
                decoration: InputDecoration(
                  labelText: 'nom',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'donner le nom du produit';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 10.0,
              ),
              TextFormField(
                controller: _prixController,
                decoration: InputDecoration(
                  labelText: 'prix',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'donner le prix du produit';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 10.0,
              ),
              TextFormField(
                controller: _codeController,
                decoration: InputDecoration(
                  labelText: 'code',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'donner le code du produit';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 10.0,
              ),
              TextFormField(
                controller: _stockController,
                decoration: InputDecoration(
                  labelText: 'stock',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'donner le nombre de stock du produit';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 10.0,
              ),
              TextFormField(
                controller: _criteredemesureController,
                decoration: InputDecoration(
                  labelText: 'critere de mesure',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'donner le critere de mesure du produit';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 10.0,
              ),
              ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      var nom = _nomController.text;
                      var prix = double.parse(_prixController.text);
                      var code = double.parse(_codeController.text);
                      var stock = double.parse(_stockController.text);
                      var criteredemesure =
                          double.parse(_criteredemesureController.text);

                      var produit = Produit(
                        nom: nom,
                        prix: prix,
                        code: code,
                        stock: stock,
                        criteredemesure: criteredemesure,
                      );
                      var success = await productservice.addProduct(Produit(
                          nom: _nomController.text,
                          prix: double.parse(_prixController.text),
                          code: double.parse(_codeController.text),
                          stock: double.parse(_stockController.text),
                          criteredemesure:
                              double.parse(_criteredemesureController.text)));
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => page1()),
                      );
                    }
                  },
                  child: Text('ajouter'))
            ],
          ),
        ),
      ),
    );
  }
}
