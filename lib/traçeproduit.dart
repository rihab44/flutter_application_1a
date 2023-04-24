import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'ajouttrace.dart';
class trace {
  late String id;
  late String nomproduit;
  late String ordreservice;
  late String adressedetraveaux;
  late String nomentreprise;
  late int numerodemarche;
  late String augentdesuivie;

  trace(
    this.id, {
    required this.nomproduit,
    required this.ordreservice,
    required this.adressedetraveaux,
    required this.nomentreprise,
    required this.numerodemarche,
    required this.augentdesuivie,
  });
  trace.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    nomproduit = json['nomproduit'];
    ordreservice = json['ordreservice'];
    adressedetraveaux = json['adressedetraveaux'];
    nomentreprise = json['nomentreprise'];
    numerodemarche = json['numerodemarche'];
    augentdesuivie = json['augentdesuivie'];
  }
}

class APIService2 {
  Future<List<trace>> gettrace() async {
    const String apiUrl = 'http://localhost:3000/gettrace';
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
      List<trace> traces = [];
      for (var item in jsonData) {
        traces.add(trace.fromJson(item));
      }
      return traces;
    } else {
      throw Exception('Impossible de récupérer les données.');
    }
  }
   Future<bool> deletetrace(String id) async {
    bool status = false;
    var url = Uri.parse('http://localhost:3000/deletetrace/$id');

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
  }
}

Future<bool> updatetrace(Map<String, dynamic> trace, String id) async {
  bool status = false;
var url = Uri.parse('http://localhost:3000/updatetrace/$id');

   print('Sending update request to $url with data $trace');
  var response = await http.post(
    url,
    body: jsonEncode(trace),
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
class traceproduit extends StatefulWidget {

  @override
  State<traceproduit> createState() => _traceproduitState();
}

class _traceproduitState extends State<traceproduit> {
    late Future<List<trace>> _tracesFuture;

  @override
  void initState() {
    super.initState();
    _tracesFuture = APIService2().gettrace();
  }

  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Color.fromARGB(255, 243, 240, 244),
      appBar: AppBar(
        backgroundColor: Colors.purple,
        elevation: 0,
        title: Text("traçabilité des produits"),
      ),
body: FutureBuilder<List<trace>>(
        future: _tracesFuture,
        builder: (BuildContext context, AsyncSnapshot<List<trace>> snapshot) {
          if (snapshot.hasData) {
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: [
                  DataColumn(label: Text('nom du produit')),
                  DataColumn(label: Text('ordre service')),
                  DataColumn(label: Text('adresse de traveaux')),
                  DataColumn(label: Text('nom entreprise')),
                  DataColumn(label: Text('numero de marché')),
                   DataColumn(label: Text('augent de suivie')),
                   DataColumn(label: Text('')),



                ],
                rows: snapshot.data!
                    .map((trace) => DataRow(cells: [
  DataCell(Text(trace.nomproduit)),
    DataCell(Text(trace.ordreservice)),
  DataCell(Text(trace.adressedetraveaux)),
  DataCell(Text(trace.nomentreprise)),
   DataCell(Text(trace.numerodemarche.toString())),
    DataCell(Text(trace.augentdesuivie)),


  DataCell(
    Row(
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Color.fromARGB(255, 174, 45, 196),
          ),
          child: Text('Modifier'),
          onPressed: () {
            edittraceDialog(trace);
          },
        ),
        SizedBox(width: 8),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Color.fromARGB(255, 220, 87, 235),
          ),
          child: Text('Supprimer'),
          onPressed: () async {
            bool status = await APIService2().deletetrace(trace.id);
            print('Delete status: $status');
            if (status) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text('traçe de produit supprimé')));
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Impossible de supprimer la traçe de produit')));
            }
          },
        ),
      ],
    ),
  ),
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
      floatingActionButton: FloatingActionButton(
    onPressed: (){
      Navigator.push(
      context,
      MaterialPageRoute(builder: (context) =>ajouttrace()),
    );
    },
    backgroundColor: Colors.purple,
    child: Icon(Icons.add),
  ),
    );
  }
  void edittraceDialog(trace) {
  TextEditingController nomproduitController =
      TextEditingController(text: trace.nomproduit);
  TextEditingController ordreserviceController =
      TextEditingController(text: trace.ordreservice);
      TextEditingController adressedetraveauxController =
      TextEditingController(text: trace.adressedetraveaux);
      TextEditingController nomentrepriseController =
      TextEditingController(text: trace.nomentreprise);
  TextEditingController numerodemarcheController =
      TextEditingController(text: trace.numerodemarche.toString());
      TextEditingController augentdesuivieController =
      TextEditingController(text: trace.augentdesuivie);

  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Modifier le traçe de produit'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: nomproduitController,
                decoration: InputDecoration(hintText: 'Nom du produit'),
              ),
              TextField(
                controller: ordreserviceController,
                decoration: InputDecoration(hintText: 'ordre service'),
              ),
              TextField(
                controller: nomentrepriseController,
                decoration: InputDecoration(hintText: 'nom entreprise'),
              ),
              TextField(
                controller: numerodemarcheController,
                decoration: InputDecoration(hintText: 'Numéro de marché'),
                keyboardType: TextInputType.number,
              ),
               TextField(
                controller: augentdesuivieController,
                decoration: InputDecoration(hintText: 'augent de suivie'),
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
                Map<String, dynamic> tracetoupdate = {
                  'nomproduit': nomproduitController.text,
                  'ordreservice': ordreserviceController.text,
                   'nomentreprise': nomentrepriseController.text,
                   'numerodemarche': int.parse(numerodemarcheController.text),

                  'augentdesuivie':augentdesuivieController.text,

                };
                bool status =
                    await updatetrace(tracetoupdate, trace.id);
                print('Update status: $status');
                if (status) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text('traçe produit mis à jour')));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Impossible de mettre à jourle traçe de produit')));
                }
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      });
}

}

