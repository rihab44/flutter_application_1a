import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Profile {
  late String id;
  late String nom;
  late String email;
  late int numero;

  Profile({
    required this.id,
    required this.nom,
    required this.email,
    required this.numero,
  });

  Profile.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    nom = json['nom'];
    email = json['email'];
    numero = json['numero'];
  }
}

class APIService4 {
  Future<Profile> getProfile(String id) async {
    String apiUrl = 'http://localhost:3000/user/$id';
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
      if (jsonData is Map<String, dynamic>) {
        return Profile.fromJson(jsonData);
      } else {
        throw Exception('Impossible de récupérer les données.');
      }
    } else {
      throw Exception('Impossible de récupérer les données.');
    }
  }
}

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  late Future<Profile> _profileFuture;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  void _loadProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = prefs.getString('userId') ?? '';
    setState(() {
      _profileFuture = APIService4().getProfile(userId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
      ),
      body: FutureBuilder<Profile>(
        future: _profileFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasData) {
            Profile profile = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Name: ${profile.nom}',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Email: ${profile.email}',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Phone Number: ${profile.numero}',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            );
          }
          return Center(
 child: CircularProgressIndicator(),
);}));}}