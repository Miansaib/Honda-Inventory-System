import 'package:flutter/material.dart';
import 'package:hondainventory/Auth/Reset_Password_Screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Auth/Login_Screen.dart';
import 'Auth/Signup_Screen.dart';
import 'Screens/Report Screen.dart';
import 'Screens/AddProductScreen.dart';
import 'Screens/BillingScreen.dart';
import 'Screens/Edit_Screen.dart';
import 'Screens/History_Screen.dart';
import 'Screens/Home_Screen.dart';
import 'package:firebase_core/firebase_core.dart';

import 'Utilities/Constants.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  status = prefs.getBool('isLoggedIn') ?? false;
  runApp(MaterialApp(
    title: 'Honda Inventory',
    theme: ThemeData(
      primarySwatch: Colors.red,
    ),
    home:  status==true?const HomeScreen():LoginScreen(),
    debugShowCheckedModeBanner: false,
    routes: {
      '/HomeScreen': (BuildContext context) => HomeScreen(),
      '/AddNewStockScreen': (BuildContext context) => AddProductScreen(),
      '/BillingScreen': (BuildContext context) => BillingScreen(),
      '/EditScreen': (BuildContext context) => EditScreen(),
      '/LoginScreen': (BuildContext context) => LoginScreen(),
      '/SignupScreen': (BuildContext context) => SignupScreen(),
      '/HistoryScreen': (BuildContext context) => HistoryScreen(),
      '/ReportScreen': (BuildContext context) => ReportScreen(),
      '/ResetScreen': (BuildContext context)=> ResetPasswordScreen(),
    },
  ));
}
