import 'package:flutter/material.dart';
import 'cable.dart';
import 'accessoire.dart';

class commande extends StatefulWidget {
  const commande({super.key});

  @override
  State<commande> createState() => _commandeState();
}

class _commandeState extends State<commande> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 241, 213, 246),
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.purple,
          title: Text('ajoutcommande',
              style: TextStyle(
                color: Color.fromARGB(255, 254, 251, 251),
                fontSize: 30,
              ))),
              body: Container(
               padding: EdgeInsets.all(30.0),
                  
        child: GridView.count(crossAxisCount:1, children: <Widget>[
               Card(
            margin: EdgeInsets.all(5.0),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => cableproduct() ),
                );
              },
              splashColor: Colors.purple,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(
                      Icons.source,
                      size: 40.0,
                      color: Colors.deepPurple,
                    ),
                    Text(
                      "les cables ",
                      style: new TextStyle(fontSize: 14.0),
                    )
                  ],
                ),
              ),
            ),
          ), 
           Card(
            margin: EdgeInsets.all(5.0),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => accessoireproduct()
                  
                  ),
                );
              },
              splashColor: Colors.purple,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(
                      Icons.source,
                      size: 40.0,
                      color: Colors.deepPurple,
                    ),
                    Text(
                      "  les accessoires ",
                      style: new TextStyle(fontSize: 14.0),
                    )
                  ],
                ),
              ),
            ),
          ),  
        ])     

              )
    );
  }
}
