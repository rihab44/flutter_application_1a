import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'page.dart';
import 'addProduct.dart';

class produit {
  late String? nom;
  late double? prix;
  late double? code;
  late double? stock;
  late double? criteredemesure;

  produit( {
    this.nom,
    this.prix,
    this.code,
    this.stock,
    this.criteredemesure,
  });
  factory produit.fromJson(Map<String, dynamic> json) {
    return produit(
      nom: json['nom'] as String?,
      prix: json['prix'] as double?,
      code: json['code'] as double?,
      stock: json['stock'] as double?,
      criteredemesure: json['criteredemesure'] as double?,
    );
  }

  Map<String, dynamic> tojson() {
    final _data = <String, dynamic>{};
    _data["nom"] = nom;
    _data["prix"] = prix;
    _data["code"] = code;
    _data["stock"] = stock;
    _data["criteredemesure"] = criteredemesure;

    return _data;
  }
}
class productservice {
  static const String apiUrl = 'http://localhost:8000/addproduct';

  static Future<http.Response> addProduct(produit ) async {
    print(produit.tojson());
    var response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(produit.tojson()),
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
  
  var _nomController = TextEditingController();
    bool isApiCallProcess = false;
  var _prixController = TextEditingController();
  var _codeController = TextEditingController();
  var _stockController = TextEditingController();
  var _criteredemesureController = TextEditingController();
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
 
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      key: scaffoldKey,
       backgroundColor: Color.fromARGB(255, 241, 213, 246),
      appBar: AppBar(
        title: Text('ajoutproduit'),
        backgroundColor: Color.fromARGB(255, 174, 45, 196),
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
           key: globalFormKey,
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
                style: ElevatedButton.styleFrom(
              primary: Color.fromARGB(255, 174, 45, 196),
               ),
                  onPressed: () async {
                      
                    if (globalFormKey.currentState!.validate()) {
                      var nom = _nomController.text;
                      var prix = double.parse(_prixController.text);
                      var code = double.parse(_codeController.text);
                      var stock = double.parse(_stockController.text);
                      var criteredemesure =
                          double.parse(_criteredemesureController.text);
    
                      var success = await productservice.addProduct(produit(
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
