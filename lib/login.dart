import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'authservice.dart';
import 'page.dart';

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
          colors: [Colors.blue, Colors.teal],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      padding: EdgeInsets.symmetric(
        vertical: 50.0,
        horizontal: 30.0,
      ),
      child: Column(children: <Widget>[
        TextField(
          decoration: InputDecoration(labelText: 'Email'),
          onChanged: (val) {
            Email = val;
          },
        ),
        TextField(
          obscureText: true,
          decoration: InputDecoration(labelText: 'password'),
          onChanged: (val) {
            password = val;
          },
        ),
        SizedBox(height: 10.0),
        ElevatedButton(

      
          onPressed: () {
           
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>page1()),
                );
        
            
          },
          child: Text('seconnecter'),
          style: ButtonStyle(),
        ),
      ]),
    ));
  }
}
