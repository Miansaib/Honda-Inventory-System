import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../Services/Functions/Firebase_Functions.dart';
import '../Utilities/Colors.dart';
import '../Utilities/Constants.dart';
import '../Utilities/Styles.dart';
import 'CustomTextField.dart';
import 'RoundedButton.dart';

class SignupScreenContainer extends StatelessWidget {
  SignupScreenContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController namecontroller = TextEditingController(),
        passwordcontroller = TextEditingController(),
        conformpasswordcontroller = TextEditingController(),
        emailcontroller = TextEditingController();
    return Container(
      height: height * 0.6,
      width: width * 0.85,
      decoration:
          BoxDecoration(color: primaryColor, borderRadius: borderRadius),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CustomTextField(
            inputType: TextInputType.name,
            obsecureText: false,
            hint: 'Enter Full Name',
            controller: namecontroller,
            prefixIcon: Icons.perm_identity_sharp,
          ),
          CustomTextField(
            inputType: TextInputType.emailAddress,
            obsecureText: false,
            hint: 'Enter Email',
            controller: emailcontroller,
            prefixIcon: Icons.alternate_email,
          ),
          CustomTextField(
            obsecureText: true,
            hint: 'Password',
            controller: passwordcontroller,
            prefixIcon: Icons.key,
          ),
          CustomTextField(
            obsecureText: true,
            hint: 'Conform Password',
            controller: conformpasswordcontroller,
            prefixIcon: Icons.keyboard_control_rounded,
          ),
          RoundedButton(
            buttonName: 'Signup',
            ontap: () {
              if (passwordcontroller.text == conformpasswordcontroller.text &&
                  passwordcontroller.text != '' &&
                  namecontroller.text != null &&
                  emailcontroller.text != null) {
                FirebaseAuth.instance
                    .createUserWithEmailAndPassword(
                  email: emailcontroller.text,
                  password: passwordcontroller.text,
                )
                    .then(
                  (value) {
                    if (kDebugMode) {
                      print("Created New Account");
                    }

                    userSetup(namecontroller.text, emailcontroller.text);
                    Navigator.pop(context, '/HomeScreen');
                  },
                ).onError(
                  (error, stackTrace) {
                    if (kDebugMode) {
                      print("Error ${error.toString()}");
                    }
                  },
                );
              } else {
                Fluttertoast.showToast(
                    msg: 'Password doesn\'t Match',
                    backgroundColor: primaryColor,
                    textColor: whiteColor);
              }
            },
          )
        ],
      ),
    );
  }
}
