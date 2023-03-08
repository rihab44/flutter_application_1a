import 'package:flutter/material.dart';

class ajout extends StatefulWidget {
  const ajout({Key? key}) : super(key: key);

  @override
  State<ajout> createState() => _ajoutState();
}

class _ajoutState extends State<ajout> {
    var _formKey = GlobalKey<FormState>();
     var _emailController = TextEditingController();
  var _motdepasseController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        title: Text('ajout utulisateur'),
        backgroundColor: Colors.purple,
        elevation: 0,
      ),
      body: Padding(padding: 
      EdgeInsets.all(16.0),
      child: Form(
         key: _formKey,
        child: Column(
        children: [
          TextFormField(
            controller: _emailController,
           decoration: InputDecoration(
            labelText: 'Email'
           ), 
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
            controller: _motdepasseController,
           decoration: InputDecoration(
            labelText: 'motdepasse'
           ), 
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
              primary: Colors.purple,
               ),
      
          onPressed: () {
           
               
            
          },
          child: Text('seconnecter'
         
          ),
          
        ),
      ),
    

       ]
          )
      )
      )
      );
    
  }
}