import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddProduct extends StatelessWidget {
  final String name;
  final double price;
  final int weight;

  AddProduct(this.name, this.price, this.weight);

  @override
  Widget build(BuildContext context) {
    print("vvvvvvvvvvvvvvvvvvvvvvvv");
    // Create a CollectionReference called users that references the firestore collection
    CollectionReference product = FirebaseFirestore.instance.collection('products');
    print("++++++++++++++");
    product
        //.doc('us5')
        //.set({'nom': nom, 'age': age})
        .add({
          'name': name,
          'price': price,
          'weight': weight,
          'date': new DateTime.now(),
        })
        .then((value) => print("Product Added"))
        .catchError((error) => print("Failed to add product: $error"));

    return IconButton(
      onPressed: () => {},
      icon: Text(
        "new product added  !",
      ),
    );
  }
}
