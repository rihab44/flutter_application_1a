import 'package:flutter/material.dart';
import 'authservice.dart';

class user {
  late String? nom;
  late String? email;
  late double? numero;
  late String? motdepasse;
  user({
    this.nom,
    this.email,
    this.numero,
    this.motdepasse,
  });
  factory user.fromJson(Map<String, dynamic> json) {
    return user(
      nom: json['nom'] as String?,
      email: json['email'] as String?,
      numero: json['numero'] as double?,
      motdepasse: json['motdepasse'] as String?,
    );
  }
  Map<String, dynamic> tojson() {
    final _data = <String, dynamic>{};
    _data["nom"] = nom;
    _data["email"] = email;
    _data["numero"] = numero;
    _data["motdepasse"] = motdepasse;
    return _data;
  }
}

class ajout extends StatefulWidget {
  const ajout({Key? key}) : super(key: key);

  @override
  State<ajout> createState() => _ajoutState();
}

class _ajoutState extends State<ajout> {
  var _formKey = GlobalKey<FormState>();
  var _emailController = TextEditingController();
  var _nomController = TextEditingController();
  var _motdepasseController = TextEditingController();
  var _numeroController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 241, 213, 246),
        appBar: AppBar(
          title: Text('ajout utulisateur'),
          backgroundColor: Color.fromARGB(255, 174, 45, 196),
          elevation: 0,
        ),
        body: Padding(
            padding: EdgeInsets.all(16.0),
            child: Form(
                key: _formKey,
                child: Column(children: [
                  TextFormField(
                    controller: _nomController,
                    decoration: InputDecoration(labelText: 'nom'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'donner nom de utulisateur';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  TextFormField(
                    controller: _nomController,
                    decoration: InputDecoration(labelText: 'email'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'donner email de utulisateur';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  TextFormField(
                    controller: _numeroController,
                    decoration: InputDecoration(labelText: 'Numéro'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'donner numero de utulisateur';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  TextFormField(
                    controller: _motdepasseController,
                    decoration: InputDecoration(labelText: 'motdepasse'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'donner mot de passe  utulisateur';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 30.0,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(255, 174, 45, 196),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          var nom = _nomController.text;
                          var email = _emailController;
                          var numero = double.parse(_numeroController.text);
                          var motdepasse = _motdepasseController;
                         

                          var success = await AuthService.adduser(user(
                           nom: _nomController.text,
                           email :_emailController.text,
                          numero : double.parse(_numeroController.text),
                           motdepasse : _motdepasseController.text));
                             
                        }
                      },
                      child: Text('ajouter'),
                    ),
                  ),
                ]))));
  }
}
