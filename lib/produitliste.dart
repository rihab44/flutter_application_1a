import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class produit {
  late String? nom;
  late double? prix;
  late double? code;
  late double? stock;
  late double? criteredemesure;

  produit( {
    this.nom,
    this.prix,
    this.code,
    this.stock,
    this.criteredemesure,
  });

  factory produit.fromJson(Map<String, dynamic> json) {
    return produit(
     nom: json['nom'] as String?,
      prix: json['prix'] as double?,
      code: json['code'] as double?,
      stock: json['stock'] as double?,
      criteredemesure: json['criteredemesure'] as double?,
    );
  }
}

class ProductListView extends StatefulWidget {
  @override
  _ProductListViewState createState() => _ProductListViewState();
}

class _ProductListViewState extends State<ProductListView> {
  late List<produit> _products;

  @override
  void initState() {
    super.initState();
    _getProducts();
  }

  Future<void> _getProducts() async {
    final response =
        await http.get(Uri.parse('https://votre_api_url/products'));

    if (response.statusCode == 200) {
      final jsonList = jsonDecode(response.body) as List;
      setState(() {
        _products = jsonList.map((json) => produit.fromJson(json)).toList();
      });
    } else {
      throw Exception('Failed to load products');
    }
  }

  @override
  Widget build(BuildContext context) {
    return _products != null
        ? ListView.builder(
            itemCount: _products.length,
            itemBuilder: (BuildContext context, int index) {
              final produit = _products[index];
              return Card(
                child: ListTile(
                  title: Text(
                    'aaa',
                    style:
                        TextStyle(fontSize: 25.0, color: Colors.orangeAccent),
                  ),
                  
                ),
              );
            },
          )
        : Center(
            child: CircularProgressIndicator(),
          );
  }
}
