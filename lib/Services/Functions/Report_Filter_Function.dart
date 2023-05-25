import 'package:cloud_firestore/cloud_firestore.dart';

import '../Models/Report_Model.dart';
import 'Firebase_Functions.dart';

enum TimeRange {
  today,
  daily,
  monthly,
  yearly,
  allTime,
}

// Stream<List<Map<String, dynamic>>> getProductsByTimeRange(TimeRange timeRange) {
//   final collectionRef = FirebaseFirestore.instance.collection('Reports');
//   final now = DateTime.now();
//
//   late DateTime startDate;
//   switch (timeRange) {
//     case TimeRange.daily:
//       startDate = DateTime(now.year, now.month, now.day,);
//       break;
//     case TimeRange.monthly:
//       startDate = DateTime(now.year, now.month, 1);
//       break;
//     case TimeRange.yearly:
//       startDate = DateTime(now.year, 1, 1);
//       break;
//     case TimeRange.allTime:
//       startDate = DateTime(2000, 1, 1); // arbitrary date far in the past
//       break;
//     case TimeRange.today:
//       // TODO: Handle this case.
//       break;
//   }
//
//   final endDate = now.add(const Duration(days: 1));
//
//   final query = collectionRef
//       .where(FieldPath.documentId, isGreaterThanOrEqualTo: '${startDate.year}-${startDate.month}-${startDate.day}')
//       .where(FieldPath.documentId, isLessThan: '${endDate.year}-${endDate.month}-${endDate.day}');
//
//   return query.snapshots().map((snapshot) {
//     return snapshot.docs.expand((doc) {
//       final data = doc.data();
//       final products = List<Map<String, dynamic>>.from(data['products'] ?? []);
//       return products;
//     }).toList();
//   });
// }

Stream<List<Product>> getProductsByTimeRange(TimeRange timeRange) {
  final collectionRef = FirebaseFirestore.instance.collection('Reports');
  final now = DateTime.now();

  late DateTime startDate;
  switch (timeRange) {
    case TimeRange.daily:
      startDate = DateTime(now.year, now.month, now.day,);
      break;
    case TimeRange.monthly:
      startDate = DateTime(now.year, now.month, 1);
      break;
    case TimeRange.yearly:
      startDate = DateTime(now.year, 1, 1);
      break;
    case TimeRange.allTime:
      startDate = DateTime(2000, 1, 1); // arbitrary date far in the past
      break;
    case TimeRange.today:
      startDate = DateTime(now.year, now.month, now.day);
      break;
  }

  final endDate = now.add(const Duration(days: 1));

  final query = collectionRef
      .where(FieldPath.documentId, isGreaterThanOrEqualTo: '${startDate.year}-${startDate.month}-${startDate.day}')
      .where(FieldPath.documentId, isLessThan: '${endDate.year}-${endDate.month}-${endDate.day}');

  return query.snapshots().map((snapshot) {
    return snapshot.docs.expand((doc) {
      final data = doc.data();
      final products = List<Map<String, dynamic>>.from(data['products'] ?? []);
      return products.map((productData) => Product(
          name: productData['name'],
          price: productData['price'],
          wholesalePrice: productData['wholesale_price'],
          imageUrl: productData['image_url'],
          productId: productData['product_id'],
          discount: productData['discount'], datetime: productData['date_time']
      ));
    }).toList();
  });
}

