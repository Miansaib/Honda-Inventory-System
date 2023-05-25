import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hondainventory/Services/Models/Sell_Product_Model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Models/Bill_History_Model.dart';
import '../Models/ProductModel.dart';
import '../Models/Report_Model.dart';

Future<void> userSetup(String displayName, displayEmail) async {
  var firebaseUser = FirebaseAuth.instance.currentUser;
  FirebaseFirestore.instance.collection("users").doc(firebaseUser?.uid).set({
    'User Name': displayName,
    'Email': displayEmail,
  }).then((_) {
    if (kDebugMode) {
      print("success!");
    }
  });
}

void uploadNewProductData(ProductModel obj) {
  FirebaseFirestore.instance.collection("Products").doc(obj.productName).set({
    'Image URL': obj.imgURL,
    'Product Name': obj.productName,
    'Product Unit Price': obj.productPrice,
    'Product Wholesale Price': obj.productWholesalePrice,
    'Total Quantity of Parts': obj.totalParts,
    'Remaining Parts': obj.remainingParts,
    'Total Amount of Parts': obj.totalAmount,
    'Sold Units': obj.soldParts,
    'Total Discount': obj.totalDiscount,
    'Product ID': obj.serialNo,
    'Search List': divideCaseNumber(obj.productName)
  }).then((value) {
    print("Data uploaded successfully");
  }).catchError((error) {
    print("Failed to upload data: $error");
  });
}

void uploadNewBillHistory(BillHistoryModel obj) {
  FirebaseFirestore.instance.collection("Bill History").doc(obj.billID).set({
    'Customer Name': obj.customerName,
    'Phone Number': obj.phoneNo,
    'Total Bill': obj.totalBill,
    'Bill Discount': obj.billDiscount,
    'Bill ID': obj.billID,
    'List of Bought Products': obj.boughtProducts,
    'Bill To be Pay': obj.withDiscountAmount,
    'Search List': divideCaseNumber(obj.billID)
  }).then((value) {
    print("Data uploaded successfully");
  }).catchError((error) {
    print("Failed to upload data: $error");
  });
}

// Function to update a specific value in a Firestore collection
Future<void> updateValueInFirebase(
    String documentId, String fieldName, dynamic valueToUpdate) async {
  try {
    await FirebaseFirestore.instance
        .collection('Products')
        .doc(documentId)
        .update({fieldName: valueToUpdate});
    if (kDebugMode) {
      print('Value updated successfully in Firebase');
    }
  } catch (e) {
    if (kDebugMode) {
      print('Error updating value in Firebase: $e');
    }
    Fluttertoast.showToast(msg: 'Error updating value in Firebase: $e');
  }
}

Future<String?> uploadFileToFirebase(File file) async {
  try {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference storageReference =
        FirebaseStorage.instance.ref().child('images/$fileName');
    UploadTask uploadTask = storageReference.putFile(file);
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
    String imageUrl = await taskSnapshot.ref.getDownloadURL();
    return imageUrl;
  } catch (e) {
    print(e);
    return null;
  }
}

List<String> divideCaseNumber(String caseNumber) {
  // Split the case number into a list of individual digits
  List<String> digits = caseNumber.split('');

  // Initialize a list to store the prefixes
  List<String> prefixes = [];

  // Build the prefixes by concatenating the individual digits
  for (int i = 0; i < digits.length; i++) {
    String prefix = digits.take(i + 1).join();
    prefixes.add(prefix);
  }

  // Return the list of individual digits and prefixes
  return [...digits, ...prefixes];
}

Future<void> deleteDocument(String docId) async {
  try {
    await FirebaseFirestore.instance.collection('Products').doc(docId).delete();
    print('Document deleted successfully!');
  } catch (e) {
    print('Error deleting document: $e');
  }
}

Future<List<String>> getDocumentNames() async {
  List<String> documentNames = [];

  QuerySnapshot<Map<String, dynamic>> snapshot =
      await FirebaseFirestore.instance.collection('Products').get();

  snapshot.docs.forEach((doc) {
    documentNames.add(doc.id);
  });

  return documentNames;
}

Future<String> getFieldData(String docID, String fieldName) async {
  final DocumentSnapshot snapshot =
      await FirebaseFirestore.instance.collection('Products').doc(docID).get();
  if (snapshot.exists) {
    final data = snapshot.get(fieldName);
    return data.toString();
  } else {
    throw Exception('Document does not exist!');
  }
}

Future<ProductModel> getDataFromFirestore(String docID) async {
  final snapshot =
      await FirebaseFirestore.instance.collection('Products').doc(docID).get();
  final data = snapshot.data() as Map<String, dynamic>;
  final myCustomObject = ProductModel.fromJSON(data);
  return myCustomObject;
}

Future<void> addCustomerData(
    String name,
    String phoneNumber,
    String totalBill,
    String discount,
    String billID,
    String billToBePay,
    String time,
    List<String> searchList,
    List<SellProductModel> productList) async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Encode the list of Product objects as a JSON string
  String productListJson =
      json.encode(productList.map((product) => product.toMap()).toList());

  // Add the customer data to a new document in the "customers" collection
  CollectionReference customersRef = firestore.collection('Bill History');
  DocumentReference newCustomerDocRef = customersRef.doc(billID);
  await newCustomerDocRef.set({
    'Customer Name': name,
    'Phone Number': phoneNumber,
    'Total Bill': totalBill,
    'Total Discount': discount,
    'Products List': productListJson,
    'Bill ID': billID,
    'Bill To Be Pay': billToBePay,
    'Search List': searchList,
    'Date and Time': time,
  });

  print('Customer data added to Firestore.');
}




Future<void> uploadProduct(Product product) async {
  final collectionRef = FirebaseFirestore.instance.collection('Reports');

  final docId = DateTime.now().toString();
  final docRef = collectionRef.doc(docId);

  final data = {
    'name': product.name,
    'price': product.price,
    'wholesale_price': product.wholesalePrice,
    'image_url': product.imageUrl,
    'product_id': product.productId,
    'discount':product.discount,
    'data_time':product.datetime
  };

  await docRef.set(data);
}


