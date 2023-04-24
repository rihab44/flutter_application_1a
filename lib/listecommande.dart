import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class commande {
  late String id;
  late String nomproduit;
  late String typeprojet;
  late int prix;
  late String dateestime;
  late String nomutilisateur;

  commande(
    this.id, {
    required this.nomproduit,
    required this.typeprojet,
    required this.prix,
    required this.dateestime,
    required this.nomutilisateur,
  });
  commande.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    nomproduit = json['nomproduit'];
    typeprojet = json['typeprojet'];
    prix = json['prix'];
    dateestime = json['dateestimé'];
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

  Future<bool> deletecommande(String id) async {
    bool status = false;
    var url = Uri.parse('http://localhost:3000/deletecommande/$id');

    print('Sending delete request to $url');
    var response = await http.delete(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
    );
    print('Received delete response with status code ${response.statusCode}');
    if (response.statusCode == 200) {
      status = response.body.isNotEmpty;
    }
    return status;
  }}

  Future<bool> updatecommande(Map<String, dynamic> commande, String id) async {
    bool status = false;
    var url = Uri.parse('http://localhost:3000/updatecommande/$id');

    print('Sending update request to $url with data $commande');
    var response = await http.post(
      url,
      body: jsonEncode(commande),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    print('Received update response with status code ${response.statusCode}');
    if (response.statusCode == 200) {
      status = response.body.isNotEmpty;
    }
    return status;
  }


class listcomande extends StatefulWidget {

  @override
  State<listcomande> createState() => _listcomandeState();
}

class _listcomandeState extends State<listcomande> {
  late Future<List<commande>> _commandesFuture;
  int _totalPrice = 0;

  @override
  void initState() {
    super.initState();
    _commandesFuture = APIService11().getcommande();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 243, 240, 244),
      appBar: AppBar(
        backgroundColor: Colors.purple,
        elevation: 0,
        title: Text("liste des commandes"),
      ),
      body: FutureBuilder<List<commande>>(
        future: _commandesFuture,
        builder:
            (BuildContext context, AsyncSnapshot<List<commande>> snapshot) {
          if (snapshot.hasData) {
            _totalPrice = 0;
            List<DataRow> rows = snapshot.data!.map((commande) {
              _totalPrice += commande.prix;
              return DataRow(cells: [
                DataCell(Text(commande.nomproduit)),
                DataCell(Text(commande.typeprojet)),
                DataCell(Text(commande.prix.toString())),
                DataCell(Text(commande.dateestime)),
                DataCell(Text(commande.nomutilisateur)),
                DataCell(
                  Row(
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Color.fromARGB(255, 174, 45, 196),
                        ),
                        child: Text('Modifier'),
                        onPressed: () {
                          editcommadeDialog(commande);
                        },
                      ),
                      SizedBox(width: 8),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Color.fromARGB(255, 220, 87, 235),
                        ),
                        child: Text('Supprimer'),
                        onPressed: () async {
                          bool status =
                              await APIService11().deletecommande(commande.id);
                          print('Delete status: $status');
                          if (status) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('commande supprimé')));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(
                                    'Impossible de supprimer la commande')));
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ]);
            }).toList();
            rows.add(DataRow(cells: [
              DataCell(Text('Total')),
              DataCell(Text('')),
              DataCell(Text(_totalPrice.toString())),
              DataCell(Text('')),
              DataCell(Text('')),
               DataCell(Text('')),


            ]));

            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: [
                  DataColumn(label: Text('Nom du produit')),
                  DataColumn(label: Text('type de projet')),
                  DataColumn(label: Text('prix')),
                  DataColumn(label: Text('date estimé')),
                  DataColumn(label: Text('nom utilisateur')),
                  DataColumn(label: Text('')),
                ],
                rows: rows,
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

  void editcommadeDialog(commande Commande) {
    TextEditingController nomproduitController =
        TextEditingController(text: Commande.nomproduit);
    TextEditingController typeprojetController =
        TextEditingController(text: Commande.typeprojet);
    TextEditingController prixController =
        TextEditingController(text: Commande.prix.toString());
    TextEditingController nomutilisateurController =
        TextEditingController(text: Commande.nomutilisateur);
    TextEditingController dateestimeeController =
        TextEditingController(text: Commande.dateestime);

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Modifier la commande'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextField(
                  controller: nomproduitController,
                  decoration: InputDecoration(hintText: 'Nom du produit'),
                ),
                TextField(
                  controller: typeprojetController,
                  decoration: InputDecoration(hintText: 'type de projet'),
                ),
                TextField(
                  controller: prixController,
                  decoration: InputDecoration(hintText: 'prix'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: nomutilisateurController,
                  decoration: InputDecoration(hintText: 'nom utilisateur'),
                ),
                TextField(
                  controller: dateestimeeController,
                  decoration: InputDecoration(hintText: 'la date estimée'),
                ),
              ],
            ),
            actions: <Widget>[
              ElevatedButton(
                child: Text('Annuler'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              ElevatedButton(
                child: Text('Modifier'),
                onPressed: () async {
                  Map<String, dynamic> userToUpdate = {
                    'nomproduit': nomproduitController.text,
                    'typeprojet': typeprojetController.text,
                    'prix': int.parse(prixController.text),
                    'nomputilisateur': nomutilisateurController.text,
                    'dateestimee': dateestimeeController.text,
                  };
                  bool status = await updatecommande(userToUpdate, Commande.id);
                  print('Update status: $status');
                  if (status) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('commande mis à jour')));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content:
                            Text('Impossible de mettre à jour la commande')));
                  }
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
}
