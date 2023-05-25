import 'package:flutter/material.dart';
import '../Utilities/Colors.dart';
import '../Utilities/Constants.dart';
import '../Utilities/Styles.dart';
class RoundedButton extends StatelessWidget {
  VoidCallback ontap;
  String buttonName;
  RoundedButton({required this.buttonName,required this.ontap,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        height: height*0.06,
        width: width*0.35,
        decoration: BoxDecoration(
          boxShadow:  [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 6,
              offset: Offset(2, 3), // changes position of shadow
            ),
          ],
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: Colors.white,width: 2),
          color: primaryColor,

        ),
        child: Center(
          child: Text(buttonName,style: textstyle2bold,),
        ),
      ),
    );
  }
}
