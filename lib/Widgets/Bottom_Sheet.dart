import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

import '../Services/Functions/Firebase_Functions.dart';

Future<String?> showImagePicker(BuildContext context) async {
  final picker = ImagePicker();
  final bottomSheet = showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text("Take a photo"),
                onTap: () async {
                  final pickedFile =
                  await picker.getImage(source: ImageSource.camera);
                  if (pickedFile != null) {
                    File imageFile = File(pickedFile.path);
                    String? imageUrl = await uploadFileToFirebase(imageFile);
                    Fluttertoast.showToast(msg: 'Image Selected Successfully');
                    Navigator.of(context).pop(imageUrl);
                  }
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text("Choose from gallery"),
                onTap: () async {
                  final pickedFile =
                  await picker.getImage(source: ImageSource.gallery);
                  if (pickedFile != null) {
                    File imageFile = File(pickedFile.path);
                    String? imageUrl = await uploadFileToFirebase(imageFile);
                    Fluttertoast.showToast(msg: 'Image Selected Successfully');
                    Navigator.of(context).pop(imageUrl);
                  }
                },
              ),
            ],
          ),
        );
      });
  return await bottomSheet;
}