import 'package:flutter/material.dart';
import 'login.dart';
import 'produit.dart';
import 'ajoututulisateur.dart';

class page1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 241, 213, 246),
      appBar: AppBar(
          toolbarHeight: 100,
          backgroundColor: Colors.purple,
          title: Text('Aceuil',
              style: TextStyle(
                color: Color.fromARGB(255, 255, 255, 255),
                fontSize: 36,
              ))),
              drawer : Drawer(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children:<Widget> [
                    ListTile(
                      leading: Icon(Icons.add),
                      title: Text('ajouter un utulisateur'),
                      onTap: (){
                        Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>ajout()),
                );
                      },
                    ),
                    ListTile(
                   leading: Icon(Icons.person),
                      title: Text('liste des utulisateurs'),  
                    ),
                    ListTile(
                      leading: Icon(Icons.add),
                      title: Text('ajouter un produit'),
                      onTap: (){
                        Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>AddProductScreen()),
                );
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.logout),
                      title: Text('deconnexion'),
                      onTap: (){
                        Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>loginpage()),
                );
                      },
                    )

                  ],
                 ),
              )
      ,body: Container(
        padding: EdgeInsets.all(30.0),
        child: GridView.count(crossAxisCount: 2, children: <Widget>[
          Card(
            margin: EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => page1()),
                );
              },
              splashColor: Colors.purple,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(
                      Icons.source,
                      size: 70.0,
                      color: Colors.deepPurple,
                    ),
                    Text(
                      "voir le stock ",
                      style: new TextStyle(fontSize: 17.0),
                    )
                  ],
                ),
              ),
            ),
          ),
          Card(
            margin: EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddProductScreen()
                  
                  ),
                );
              },
              splashColor: Colors.purple,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(
                      Icons.add_shopping_cart,
                      size: 70.0,
                      color: Colors.deepPurple,
                    ),
                    Text(
                      "gestion des commandes ",
                      style: new TextStyle(fontSize: 17.0),
                    )
                  ],
                ),
              ),
            ),
          ),
          Card(
            margin: EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>page1()),
                );
              },
              splashColor: Colors.purple,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(
                      Icons.trending_up,
                      size: 70.0,
                      color: Colors.deepPurple,
                    ),
                    Text(
                      "voir la tracabilité du produitt ",
                      style: new TextStyle(fontSize: 17.0),
                    )
                  ],
                ),
              ),
            ),
          ),
          Card(
            margin: EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => page1()),
                );
              },
              splashColor: Colors.purple,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(
                      Icons.production_quantity_limits,
                      size: 70.0,
                      color: Colors.deepPurple,
                    ),
                    Text(
                      "traffic  ",
                      style: new TextStyle(fontSize: 17.0),
                    )
                  ],
                ),
              ),
            ),
          ),
          Card(
            margin: EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>page1()),
                );
              },
              splashColor: Colors.purple,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(
                      Icons.description,
                      size: 70.0,
                      color: Colors.deepPurple,
                    ),
                    Text(
                      " les projets ",
                      style: new TextStyle(fontSize: 17.0),
                    )
                  ],
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
