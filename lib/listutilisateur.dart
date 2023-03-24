import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class user {
  late String nom;
  late String email;
  late double numero;

  late String password;

  user({ required this.nom,  required this.email,  required this.numero,  required this.password});
  user.fromJson(Map<String, dynamic> json) {
    nom = json['nom'];
    email = json['email'];
    numero = json['code'];
    password = json['password'];
    
  }
}
class APIService1 {
  Future<List<user>> getProduit() async {
    const String apiUrl = 'http://localhost:3000/users';
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
      List<user> produits = [];
      for (var item in jsonData) {
        produits.add(user.fromJson(item));
      }
      return produits;
    } else {
      throw Exception('Impossible de récupérer les données.');
    }
  }
}
class MyDataTable1 extends StatefulWidget {
  @override
  _MyDataTable1State createState() => _MyDataTable1State();
}

class _MyDataTable1State extends State<MyDataTable1> {
  late Future<List<user>> _produitsFuture;

  @override
  void initState() {
    super.initState();
    _produitsFuture = APIService1().getProduit();
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
      body: FutureBuilder<List<user>>(
        future: _produitsFuture,
        builder: (BuildContext context, AsyncSnapshot<List<user>> snapshot) {
          if (snapshot.hasData) {
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: [
                  DataColumn(label: Text('Nom')),
                  DataColumn(label: Text('email')),
                  DataColumn(label: Text('numero')),
                  DataColumn(label: Text('password')),
                 
                ],
                rows: snapshot.data!.map((produit) => DataRow(cells: [
                      DataCell(Text(produit.nom)),
                      DataCell(Text(produit.email)),
                      DataCell(Text(produit.numero.toString())),
                      DataCell(Text(produit.password)),
                      
                    ])).toList(),
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("${snapshot.error}"),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

