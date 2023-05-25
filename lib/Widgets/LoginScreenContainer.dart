import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Screens/Home_Screen.dart';
import '../Utilities/Colors.dart';
import '../Utilities/Constants.dart';
import '../Utilities/Styles.dart';
import 'CustomTextField.dart';
import 'RoundedButton.dart';

class LoginScreenContainer extends StatelessWidget {
  TextEditingController emailController,
      passwordController;
  LoginScreenContainer({required this.passwordController,required this.emailController,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: height * 0.1),
      child: Container(
        height: height * 0.45,
        width: width * 0.8,
        decoration: BoxDecoration(
            color: primaryColor, borderRadius: BorderRadius.circular(30)),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomTextField(
                    inputType: TextInputType.emailAddress,
                    obsecureText: false,
                    controller: emailController,
                    prefixIcon: Icons.alternate_email,
                    hint: 'Enter Email',
                  ),
                  CustomTextField(
                    obsecureText: true,
                    controller: passwordController,
                    prefixIcon: Icons.key,
                    hint: 'Enter Password',
                  ),
                  RoundedButton(
                    ontap: () async {
                      FirebaseAuth.instance
                          .signInWithEmailAndPassword(
                          email: emailController.text,
                          password: passwordController.text)
                          .then((value) {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx)=>HomeScreen()));
                      }).onError((error, stackTrace) {
                        if (kDebugMode) {
                          print("Error ${error.toString()}");
                        }
                        Fluttertoast.showToast(
                            msg: error.toString(),
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.SNACKBAR,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      });
                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      prefs.setBool("isLoggedIn", true);
                    },
                    buttonName: 'Login',
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/ResetScreen');
                      },
                      child: Text(
                        'Forgot Password?',
                        style: textstyle0bold,
                      )),
                  GestureDetector(
                      onLongPress: () {
                        Navigator.pushNamed(context, '/SignupScreen');
                      },
                      child: Text(
                          'Signup',
                          style: textstyle1bold
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
