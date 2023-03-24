import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'page.dart';

class Produit {
  String nom;
  String type;
  double prix;
  double code;
  double stock;
  double criteredemesure;

  Produit(this.nom, this.type, this.prix, this.code, this.stock,
      this.criteredemesure);
  Map<String, dynamic> toJson() {
    return {
      'nom': this.nom,
      'type': this.type,
      'prix': this.prix,
      'code': this.code,
      'stock': this.stock,
      'criteredemesure': this.criteredemesure,
    };
  }
}

class productservice {
  static const String apiUrl = 'http://localhost:8000/addproduct';

  static Future<http.Response> addProduct(Map<String, dynamic> produit) async {
    var response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        "Access-Control-Allow-Origin": "*",
        'Content-Type': 'application/json',
        'Accept': '*/*',
      },
      body: jsonEncode(produit),
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
  var _typeController = TextEditingController();

  var _prixController = TextEditingController();
  var _codeController = TextEditingController();
  var _stockController = TextEditingController();
  var _criteredemesureController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 241, 213, 246),
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
                  width: double.infinity,
                  height: 30.0,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(255, 174, 45, 196),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          var nom = _nomController.text;
                          var type = _typeController.text;
                          var prix = double.parse(_prixController.text);
                          var code = double.parse(_codeController.text);
                          var stock = double.parse(_stockController.text);
                          var criteredemesure =
                              double.parse(_criteredemesureController.text);
                          var success = productservice.addProduct(
                              Produit(nom,type, prix, code, stock, criteredemesure)
                                  .toJson());
                          print(jsonEncode(
                              Produit(nom,type, prix, code, stock, criteredemesure)
                                  .toJson()));

                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => page1()),
                          );
                        }
                      },
                      child: Text('ajouter'))),
            ],
          ),
        ),
      ),
    );
  }
}
