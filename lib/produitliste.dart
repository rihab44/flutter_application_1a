import 'dart:async';
import 'dart:convert';
import 'ProductDetail.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ListProducts extends StatefulWidget {
  @override
  _ListProductsState createState() => _ListProductsState();
}

class _ListProductsState extends State<ListProducts> {
  List products = [];
  bool isLoading = false;

  void initState() {
    // TODO: implement initState
    super.initState();
    this.fetchproduct();
  }

 Future<void> fetchproduct() async {
    setState(() {
      isLoading = true;
    });
    var url = Uri.parse("http://localhost:8000/addproduct");
    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var items = json.decode(response.body)['results'];
        setState(() {
          products = List<Map<String, dynamic>>.from(items);
          isLoading = false;
        });
      } else {
        setState(() {
          products = [];
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        products = [];
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Listviews Products"),
        backgroundColor: Colors.purple,
        elevation: 0,
      ),
      body: getBody(),
    );
  }

  Widget getBody() {
    if (products.isEmpty || isLoading) {
      return Center(child: CircularProgressIndicator());
    }
    return ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          return getCard(products[index]);
        });
  }

  Widget getCard(item) {
        var nom = item['nom'];

    return Card(
        elevation: 1.5,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductDetail(product: item),
              ),
            );}
          , child: ListTile(
          title: Row(
            children: <Widget>[
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(60/2),
                  ),
              ),
              SizedBox(width: 20,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    width: MediaQuery.of(context).size.width-140,
                    child: Text(nom.toString(),style: TextStyle(fontSize: 17),)
                  
                    ),
                  ])
            ]))
    )));
  }
}
