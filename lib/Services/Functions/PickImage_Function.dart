// import 'dart:io';
// import 'package:flutter/foundation.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:flutter/material.dart';
// import '../../Utilities/Colors.dart';
// import '../../Utilities/Constants.dart';
// import '../../Utilities/Styles.dart';
// import 'Firebase_Functions.dart';
//
// Future<String?> showImagePickerBottomSheet(BuildContext context) async {
//   Future<String?> imgURL;
//   await showModalBottomSheet(
//     shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(
//       top: Radius.circular(50),
//     )),
//     context: context,
//     builder: (BuildContext context) {
//       return ClipRRect(
//         borderRadius: BorderRadius.vertical(
//           top: Radius.circular(50),
//         ),
//         child: Container(
//           height: height * 0.2,
//           decoration: BoxDecoration(
//             color: primaryColor,
//           ),
//           padding: EdgeInsets.all(16),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               GestureDetector(
//                 onTap: ()  {
//                   imgURL=uploadImageToFirebase(ImageSource.camera);
//                 },
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     Container(
//                       height: height * 0.1,
//                       width: height * 0.1,
//                       decoration: BoxDecoration(
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black.withOpacity(0.2),
//                             spreadRadius: 2,
//                             blurRadius: 6,
//                             offset: Offset(2, 3), // changes position of shadow
//                           ),
//                         ],
//                         shape: BoxShape.circle,
//                         color: primaryColor,
//                       ),
//                       child: Center(
//                         child: Icon(
//                           Icons.camera_alt,
//                           color: whiteColor,
//                         ),
//                       ),
//                     ),
//                     Text(
//                       'Camera',
//                       style: textstyle0,
//                     ),
//                   ],
//                 ),
//               ),
//               GestureDetector(
//                 onTap: () async {
//
//                     imgURL = uploadImageToFirebase(ImageSource.gallery);
//
//                 },
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     Container(
//                       height: height * 0.1,
//                       width: height * 0.1,
//                       decoration: BoxDecoration(
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black.withOpacity(0.2),
//                             spreadRadius: 2,
//                             blurRadius: 6,
//                             offset: Offset(2, 3), // changes position of shadow
//                           ),
//                         ],
//                         shape: BoxShape.circle,
//                         color: primaryColor,
//                       ),
//                       child: Center(
//                         child: Icon(
//                           Icons.folder,
//                           color: whiteColor,
//                         ),
//                       ),
//                     ),
//                     Text(
//                       'Files',
//                       style: textstyle0,
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       );
//     },
//   );
//   return await imgURL;
// }

