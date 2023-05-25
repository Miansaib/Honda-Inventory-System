import 'package:cloud_firestore/cloud_firestore.dart';

class SellProductModel {
  String productName;
  String productID;
  String discount;
  String price;
  String imageURL;

  SellProductModel(
      {required this.productName,
        required this.productID,
        required this.discount,
        required this.price,
      required this.imageURL});

  Map<String, dynamic> toMap() {
    return {
      'productName': productName,
      'productID': productID,
      'discount': discount,
      'price': price,
      'imageURL': imageURL,
    };

  }
  // Create a new Product instance from a Firestore document snapshot
  static SellProductModel fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return SellProductModel(
      productName: data['productName'] as String,
      productID: data['productID'] as String,
      discount: data['discount'] as String,
      price: data['price'] as String,
      imageURL: data['imageURL'] as String,
    );
  }
}


