import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hondainventory/Utilities/Colors.dart';
import 'package:hondainventory/Utilities/Constants.dart';
import 'package:hondainventory/Utilities/Styles.dart';
import 'package:hondainventory/Widgets/CustomAppBar.dart';
import 'package:hondainventory/Widgets/CustomTextField.dart';
import 'package:hondainventory/Widgets/RoundedButton.dart';

class ResetPasswordScreen extends StatelessWidget {
  TextEditingController controller = TextEditingController();

  ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: CustomAppBar(
                AppbarIcon: Icons.reset_tv_sharp,
                visibility: true,
                ontap: () {
                  Navigator.pop(context);
                }),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              height: height * 0.3,
              width: width * 0.85,
              decoration: BoxDecoration(
                  borderRadius: borderRadius, color: primaryColor),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomTextField(
                    inputType: TextInputType.emailAddress,
                      obsecureText: false,
                      hint: 'Enter Email',
                      controller: controller,
                      prefixIcon: Icons.alternate_email_outlined),
                  RoundedButton(
                      buttonName: 'Submit',
                      ontap: () {
                        FirebaseAuth.instance
                            .sendPasswordResetEmail(email: controller.text)
                            .then((value) => Navigator.of(context).pop())
                            .whenComplete(() => Fluttertoast.showToast(
                                msg: 'An Email has been sent to you account',gravity: ToastGravity.SNACKBAR));
                      })
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
