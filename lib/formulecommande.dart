import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'page.dart';

class commande {
  String nomproduit;
  String typeprojet;
  double prix;
  String nomutilisateur;

  commande(
    this.nomproduit,
    this.typeprojet,
    this.prix,
    this.nomutilisateur,
  );
  Map<String, dynamic> toJson() {
    return {
      'nomproduit': this.nomproduit,
      'typeprojet': this.typeprojet,
      'codeoracle': this.prix,
      'nomutilisateur': this.nomutilisateur,
    };
  }
}

class productservice {
  static const String apiUrl = 'http://localhost:3000/addcommande';

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
  final String nomProduitCommande;
  final String typeprojetCommande;
  final String prixproduit;

  AddProductScreen(
      {required this.nomProduitCommande,
      required this.typeprojetCommande,
      required this.prixproduit});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  var _formKey = GlobalKey<FormState>();

  var _codeoracleController = TextEditingController();

  var _nomutilisateurController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 241, 213, 246),
      appBar: AppBar(
        title: Text('commander'),
        backgroundColor: Colors.purple,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Text(widget.nomProduitCommande),
              SizedBox(
                height: 10.0,
              ),
              Text('type de projet'),
              Text(widget.typeprojetCommande),
              SizedBox(
                height: 10.0,
              ),
              Text(widget.prixproduit),
              SizedBox(
                height: 10.0,
              ),
              TextFormField(
                controller: _nomutilisateurController,
                decoration: InputDecoration(
                  labelText: 'nom utilisateur',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'donner nom utilisateur';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 10.0,
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
                          var nomproduit = widget.nomProduitCommande;

                          var typeprojet = widget.typeprojetCommande;
                          var prix = widget.prixproduit;
                          var nomutilisateur = _nomutilisateurController.text;

                          var success = productservice.addProduct(commande(
                            nomproduit,
                            typeprojet,
                            double.parse(prix)  ,
                            nomutilisateur,
                          ).toJson());
                          print(jsonEncode(commande(nomproduit, typeprojet,
                                 double.parse(prix),nomutilisateur)
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
