import 'package:flutter/material.dart';
class ProductDetail extends StatelessWidget {
  final Map product;

  ProductDetail({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product Detail"),
        backgroundColor: Colors.purple,
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(product['nom'], style: TextStyle(fontSize: 20.0)),
            SizedBox(height: 16.0),
            Text(product['description'], style: TextStyle(fontSize: 16.0)),
            SizedBox(height: 16.0),
            Text("\$${product['prix']}", style: TextStyle(fontSize: 18.0)),
          ],
        ),
      ),
    );
  }
}
