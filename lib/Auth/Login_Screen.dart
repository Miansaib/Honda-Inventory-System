import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Utilities/Colors.dart';
import '../Utilities/Constants.dart';
import '../Utilities/Styles.dart';
import '../Widgets/CustomAppBar.dart';
import '../Widgets/CustomTextField.dart';
import '../Widgets/LoginScreenContainer.dart';
import '../Widgets/RoundedButton.dart';
class LoginScreen extends StatefulWidget {

  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController=TextEditingController(),passwordController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    height=MediaQuery.of(context).size.height;
    width=MediaQuery.of(context).size.width;
    return  Scaffold(
      body: Stack(
        children: [
          CustomAppBar(AppbarIcon: Icons.assignment_ind_outlined, visibility: false, ontap: () {  },),
          Align(
              alignment: Alignment.center,
              child: LoginScreenContainer(passwordController: passwordController, emailController: emailController,)),
        ],
      ),
    );
  }
}
