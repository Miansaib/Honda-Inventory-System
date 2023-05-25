import 'package:flutter/material.dart';

import '../Utilities/Colors.dart';
import '../Utilities/Constants.dart';
import '../Utilities/Styles.dart';
class HomeScreenContainer extends StatelessWidget {
  VoidCallback ontap;
  IconData containerIcon;
  String buttonName;
  HomeScreenContainer({required this.ontap,required this.buttonName,required this.containerIcon,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: ontap,
      child: Container(

        height: height*0.15,
        width: height*0.15,
        decoration: BoxDecoration(
            boxShadow:  [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 6,
                offset: Offset(2, 3), // changes position of shadow
              ),
            ],
          color: primaryColor,
          borderRadius: BorderRadius.circular(20)
        ),
        child: Center(child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(containerIcon,size: 40,color: whiteColor,),
            Text(buttonName,style: textstyle1,textAlign: TextAlign.center,)
          ],
        ),),
      ),
    );
  }
}
