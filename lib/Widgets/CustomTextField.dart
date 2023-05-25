import 'package:flutter/material.dart';
import '../Utilities/Colors.dart';
import '../Utilities/Constants.dart';
import '../Utilities/Styles.dart';

class CustomTextField extends StatelessWidget {
  String hint;
  bool obsecureText;
  TextEditingController controller;
  IconData prefixIcon;
  TextInputType? inputType = TextInputType.text;
  VoidCallback? onTap=(){};

  CustomTextField(
      {this.inputType,
      required this.obsecureText,
      required this.hint,
      required this.controller,
      required this.prefixIcon,
        this.onTap,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Colors.black26.withOpacity(0.2),
          spreadRadius: 2,
          blurRadius: 5,
          offset: Offset(0, 3),
        ),
      ], borderRadius: borderRadius),
      height: height * 0.07,
      width: width * 0.7,
      child: TextField(
        onTap: onTap,
        keyboardType: inputType,
        style: textstyle0,
        cursorColor: whiteColor,
        obscureText: obsecureText,
        controller: controller,
        decoration: InputDecoration(
            fillColor: primaryColor,
            filled: true,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: BorderSide(
                style: BorderStyle.solid,
                color: whiteColor,
              ),
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide(
                  style: BorderStyle.solid,
                  color: whiteColor,
                )),
            hintText: hint,
            hintStyle: textstyle1,
            prefixIcon: Icon(
              prefixIcon,
              color: whiteColor,
              size: 20,
            ),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide(
                  style: BorderStyle.solid,
                  color: whiteColor,
                ))),
      ),
    );
  }
}
