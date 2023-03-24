import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1a/formulecommande.dart';
import 'package:http/http.dart' as http;

class Produit {
  late String nom;
  late int prix;
  late int code;
  late int stock;
  late int criteredemesure;
  bool selected = false;

  Produit({
    required this.nom,
    required this.prix,
    required this.code,
    required this.stock,
    required this.criteredemesure,
  });

  Produit.fromJson(Map<String, dynamic> json) {
    nom = json['nom'];
    prix = json['prix'];
    code = json['code'];
    stock = json['stock'];
    criteredemesure = json['criteredemesure'];
  }
}

class APIService {
  Future<List<Produit>> getProduit() async {
    const String apiUrl = 'http://localhost:8000/products';
    var response = await http.get(
      Uri.parse(apiUrl),
      headers: {
        "Access-Control-Allow-Origin": "*",
        'Content-Type': 'application/json',
        'Accept': '*/*',
      },
    );

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      List<Produit> produits = [];
      for (var item in jsonData) {
        produits.add(Produit.fromJson(item));
      }
      return produits;
    } else {
      throw Exception('Impossible de récupérer les données.');
    }
  }
}

class MyDataTablec extends StatefulWidget {
  @override
  _MyDataTablecState createState() => _MyDataTablecState();
}

class _MyDataTablecState extends State<MyDataTablec> {
  late Future<List<Produit>> _produitsFuture;
  List<Produit> _selectedProduits = [];

  void _onProduitSelected(Produit produit) {
    setState(() {
      produit.selected = !produit.selected;
      if (produit.selected) {
        _selectedProduits.add(produit);
      } else {
        _selectedProduits.remove(produit);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _produitsFuture = APIService().getProduit();
  }

  @override
 
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: Color.fromARGB(255, 241, 213, 246),
    appBar: AppBar(
      backgroundColor: Colors.purple,
      elevation: 0,
      title: Text("liste des produits"),
    ),
    body: FutureBuilder<List<Produit>>(
      future: _produitsFuture,
      builder: (BuildContext context, AsyncSnapshot<List<Produit>> snapshot) {
        if (snapshot.hasData) {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: [
                DataColumn(label: Text('Nom')),
                DataColumn(label: Text('Prix')),
                DataColumn(label: Text('Code')),
                DataColumn(label: Text('Stock')),
                DataColumn(label: Text('Critère de mesure'))
              ],
              rows: snapshot.data!
                  .map((produit) => DataRow(
                    selected: produit.selected,
                    onSelectChanged: (selected) => _onProduitSelected(produit),
                    cells: [
                      DataCell(Text(produit.nom)),
                      DataCell(Text(produit.prix.toString())),
                      DataCell(Text(produit.code.toString())),
                      DataCell(Text(produit.stock.toString())),
                      DataCell(Text(produit.criteredemesure.toString())),
                    ],
                  ))
                  .toList(),
            ),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text("${snapshot.error}"),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    ),
    floatingActionButton: buildSubmit(),
  );
}

Widget buildSubmit() => Container(
  width: double.infinity,
  padding: EdgeInsets.all(12),
  
  child: ElevatedButton(
    style: ElevatedButton.styleFrom(
      primary: Color.fromARGB(255, 174, 45, 196),
    ),
    child: Text('commander'),
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AddProductScreen()),
      );
    },
  ),
);
}