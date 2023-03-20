import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  List users = [];
  bool isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.fetchUser();
  }

  fetchUser() async {
    setState(() {
      isLoading = true;
    });
    final response = await http.get(Uri.parse('https://votre_api_url/users'));

    // print(response.body);
    if (response.statusCode == 200) {
      var items = json.decode(response.body)['results'];
      setState(() {
        users = items;
        isLoading = false;
      });
    } else {
      users = [];
      isLoading = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 241, 213, 246),
      appBar: AppBar(
        title: Text('liste des utilisateurs'),
        backgroundColor: Color.fromARGB(255, 174, 45, 196),
        elevation: 0,
      ),
      body: getBody(),
    );
  }

  Widget getBody() {
    if (users.contains(null) || users.length < 0 || isLoading) {
      return Center(
        child: CircularProgressIndicator(
          color: Colors.purple,
        ),
      );
    }
    return ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          return getCard(users[index]);
        });
  }

  Widget getCard(item) {
    var nom = item['nom'];
    var email = item['email'];
    var numero = item['numero'];
    var motdepasse = item['motdepasse'];
    return Card(
      elevation: 1.5,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListTile(
          title: Row(
            children: <Widget>[
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(60 / 2),
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                      width: MediaQuery.of(context).size.width - 140,
                      child: Text(
                        nom,
                        style: TextStyle(fontSize: 17),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    email.toString(),
                    style: TextStyle(color: Colors.grey),
                  ),
                    SizedBox(
                    height: 10,
                  ),
                  Text(
                    numero.toString(),
                    style: TextStyle(color: Colors.grey),
                  ),
                    SizedBox(
                    height: 10,
                  ),
                  Text(
                    motdepasse.toString(),
                    style: TextStyle(color: Colors.grey),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
