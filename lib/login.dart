import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'page.dart';
import 'package:http/http.dart' as http ;
import 'dart:convert';

class loginpage extends StatefulWidget {
  const loginpage({super.key});

  @override
  State<loginpage> createState() => _loginpageState();
}

class _loginpageState extends State<loginpage> {
  var Email, password, token;
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light
        .copyWith(statusBarColor: Colors.transparent));
    return Scaffold(
        body: Container(
          
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color.fromARGB(255, 139, 11, 139), Color.fromARGB(255, 211, 92, 238)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      padding: EdgeInsets.symmetric(
        vertical: 50.0,
        horizontal: 30.0,
      ),
      
      
        child: Column(children: <Widget>[
          Text(
          'Connexion',
          style: TextStyle(
            fontSize: 32.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 10.0,),
        Text(
          'connectez vous pour accéder à votre compte',
          style: TextStyle(
            color: Colors.white,
          )
        ),

        TextField(
          decoration: InputDecoration(labelText: 'Email'),
          onChanged: (val) {
            Email = val;
          },
        ),
        TextField(
          obscureText: true,
          decoration: InputDecoration(labelText: 'motdepasse'),
          onChanged: (val) {
            password = val;
          },
        ),
        SizedBox(
           width: double.infinity,
             height: 30.0,
        child: ElevatedButton(
       style: ElevatedButton.styleFrom(
              primary: Color.fromARGB(255, 244, 235, 246),
               ),
      
          onPressed: () async {
             var response = await http.post(
    Uri.parse('http://localhost:3000/authenticate'),
    body: {'email': Email, 'password': password},
  );
  if (response.statusCode == 200) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) =>page1()),
    );
  } else {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Erreur de connexion'),
          content: Text('Email ou mot de passe incorrect'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
},
           
      
          child: Text('seconnecter'
          ,style: TextStyle(
            color: Color.fromARGB(255, 22, 1, 28)
          ) ,
          ),
          
        ),
      ),
      ]),
    ));
  }
}
