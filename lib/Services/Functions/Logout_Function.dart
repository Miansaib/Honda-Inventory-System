import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> logoutUser(context,Widget) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.clear();
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx)=>Widget)
  );
}