import 'package:flutter/material.dart';

import '../Utilities/Colors.dart';
import '../Utilities/Constants.dart';
import '../Utilities/Styles.dart';
class CustomFlatButton extends StatelessWidget {
  String buttonName;
  VoidCallback ontap;
  CustomFlatButton({required this.ontap,required this.buttonName,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        height: height * 0.06,
        width: width/2-10,
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(25),),
        child: Center(child: Text(buttonName,style: textstyle2bold,),),
      ),
    );
  }
}
