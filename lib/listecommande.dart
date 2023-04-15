import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class commande {
  late String nomproduit;
  late String typeprojet;
  late double prix;
  late String nomutilisateur;

  commande({
    required this.nomproduit,
    required this.typeprojet,
    required this.prix,
    required this.nomutilisateur,
  });
  commande.fromJson(Map<String, dynamic> json) {
    nomproduit = json['nomproduit'];
    typeprojet = json['typeprojet '];
    prix = json['prix'];
    nomutilisateur = json['nomutilisateur'];
  }
}

class APIService11 {
  Future<List<commande>> getcommande() async {
    const String apiUrl = 'http://localhost:3000/getcommande';
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
      List<commande> commandes = [];
      for (var item in jsonData) {
        commandes.add(commande.fromJson(item));
      }
      return commandes;
    } else {
      throw Exception('Impossible de récupérer les données.');
    }
  }
}

class listcomande extends StatefulWidget {
  const listcomande({super.key});

  @override
  State<listcomande> createState() => _listcomandeState();
}

class _listcomandeState extends State<listcomande> {
    late Future<List<commande>> _commandesFuture;

  @override
  void initState() {
    super.initState();
    _commandesFuture = APIService11().getcommande();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 241, 213, 246),
      appBar: AppBar(
        backgroundColor: Colors.purple,
        elevation: 0,
        title: Text("liste des commandes"),
      ),
       body: FutureBuilder<List<commande>>(
        future: _commandesFuture,
        builder: (BuildContext context, AsyncSnapshot<List<commande>> snapshot) {
          if (snapshot.hasData) {
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: [
                  DataColumn(label: Text('Nom du produit')),
                  DataColumn(label: Text('type de projet')),
                  DataColumn(label: Text('prix')),
                  DataColumn(label: Text('nom utilisateur')),

                 
                ],
                rows: snapshot.data!
                    .map((commande) => DataRow(cells: [
                          DataCell(Text(commande.nomproduit)),
                          DataCell(Text(commande.typeprojet)),
                          DataCell(Text(commande.prix.toString())),
                          DataCell(Text(commande.nomutilisateur)),
                          
                        ]))
                    .toList(),
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
