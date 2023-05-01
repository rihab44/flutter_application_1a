import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserProfile extends StatefulWidget {
  final String userId;

  UserProfile({required this.userId, });

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  late Map<String, dynamic> _userProfile;

  @override
  void initState() {
    super.initState();
    _fetchUserProfile();
  }

  void _fetchUserProfile() async {
    final response = await http.get(
      Uri.parse('http://localhost:3000/user/${widget.userId}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      setState(() {
        _userProfile = jsonDecode(response.body);
      });
    } else {
      throw Exception('Failed to load user profile');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
      ),
      body: _userProfile == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Name: ${_userProfile['nom']}',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Email: ${_userProfile['email']}',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Phone Number: ${_userProfile['numero']}',
                    style: TextStyle(fontSize: 20),
                  ),
                   SizedBox(height: 10),
                  Text(
                    'mot de passe: ${_userProfile['password']}',
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),
    );
  }
}
