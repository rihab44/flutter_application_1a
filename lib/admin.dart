import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'listutilisateur.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final _storage = FlutterSecureStorage();
  String? _adminEmail;
  String? _adminPassword;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _getAdminCredentials();
  }

  Future<void> _storeAdminCredentials(String email, String password) async {
    await _storage.write(key: 'admin_email', value: email);
    await _storage.write(key: 'admin_password', value: password);
  }

  Future<void> _getAdminCredentials() async {
    _adminEmail = await _storage.read(key: 'admin_email');
    _adminPassword = await _storage.read(key: 'admin_password');

    print('Admin email: $_adminEmail');
    print('Admin password: $_adminPassword');

    if (_adminEmail == null || _adminPassword == null) {
      // L'administrateur n'est pas encore connecté. Nous affichons donc la boîte de dialogue pour qu'il se connecte.
      _showAdminDialog();
    } else {
      // Vérifier si l'utilisateur est un administrateur en appelant votre API `requireAdmin`.
      final response = await http.get(
        Uri.parse('http://localhost:3000/admin'),
        headers: {'Authorization': 'Basic $_adminEmail:$_adminPassword'},
      );

      if (response.statusCode == 200) {
        setState(() {
          _isLoading = false;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
                'Vous devez être administrateur pour accéder à cette page'),
          ),
        );
      }
    }
  }

  Future<void> _showAdminDialog() async {
    String? enteredEmail;
    String? enteredPassword;

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Connectez-vous en tant qu\'administrateur'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                onChanged: (value) {
                  enteredEmail = value;
                },
                decoration: const InputDecoration(hintText: 'Email'),
              ),
              TextField(
                onChanged: (value) {
                  enteredPassword = value;
                },
                obscureText: true,
                decoration: const InputDecoration(hintText: 'Mot de passe'),
              ),
            ],
          ),
            actions: <Widget>[
              TextButton(
                child: const Text('Annuler'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text('Connexion'),
                onPressed: () async {
                  // Vérifier les informations d'identification de l'administrateur
                  if (enteredEmail == 'admin' &&
                      enteredPassword == 'password') {
                    await _storage.write(
                        key: 'admin_email', value: enteredEmail!);
                    await _storage.write(
                        key: 'admin_password', value: enteredPassword!);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyDataTable1()),
                    );
                    setState(() {
                      _isLoading = false;
                    });
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Identifiant ou mot de passe incorrect'),
                      ),
                    );
                  }
                },
              ),
            ],
          );
        },
      );
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold();
    }
  }

