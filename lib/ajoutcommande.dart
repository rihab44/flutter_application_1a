import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'page.dart';

class commande {
  String nom;
  double prix;
  double code;
  double stock;
  double criteredemesure;

  commande(this.nom, this.prix, this.code, this.stock, this.criteredemesure);
  Map<String, dynamic> toJson() {
    return {
      'nom': this.nom,
      'prix': this.prix,
      'code': this.code,
      'stock': this.stock,
      'criteredemesure': this.criteredemesure,
    };
  }
}
class commandeservice {
  static const String apiUrl = 'http://localhost:5000/addcommande';

  static Future<http.Response> addcommande(Map<String, dynamic> commande) async {
    var response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        "Access-Control-Allow-Origin": "*",
        'Content-Type': 'application/json',
        'Accept': '*/*'
      },
      body: jsonEncode(commande),
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
class ajoutcommande extends StatefulWidget {
  const ajoutcommande({Key? key}) : super(key: key);


  @override
  State<ajoutcommande> createState() => _ajoutcommandeState();
}

class _ajoutcommandeState extends State<ajoutcommande> {
    var _formKey = GlobalKey<FormState>();
    var _nomController = TextEditingController();

  var _prixController = TextEditingController();
  var _codeController = TextEditingController();
  var _stockController = TextEditingController();
  var _criteredemesureController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Color.fromARGB(255, 241, 213, 246),
      appBar: AppBar(
      title: Text('ajout commande'),
        backgroundColor: Colors.purple,
        elevation: 0,
      ),
      body: Padding( padding: EdgeInsets.all(16.0),
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
                 style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 174, 45, 196),
                     ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      var nom = _nomController.text;
                      var prix = double.parse(_prixController.text);
                      var code = double.parse(_codeController.text);
                      var stock = double.parse(_stockController.text);
                      var criteredemesure =
                          double.parse(_criteredemesureController.text);
                      print(jsonEncode(
                          commande(nom, prix, code, stock, criteredemesure)
                              .toJson()));

                      var success = await commandeservice.addcommande(
                          commande(nom, prix, code, stock, criteredemesure)
                              .toJson());
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => page1()),
                      );
                    }
                  },
                  child: Text('ajouter'))
          ],
        )
      )


      ),
      );
    
  }
}