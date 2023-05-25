import 'package:flutter/material.dart';

import '../Utilities/Colors.dart';
import '../Utilities/Constants.dart';

class CustomAppBar extends StatelessWidget {
  bool visibility;
  IconData AppbarIcon;
  VoidCallback ontap;
  CustomAppBar({required this.AppbarIcon,required this.visibility,required this.ontap,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      height: height * 0.2,
      width: width,
      decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(60),
              bottomRight: Radius.circular(60))),
      child: Stack(
        children: [
          Center(child: Container(child: Center(child: Icon(AppbarIcon,color: whiteColor,size: 50,),),),),
          Visibility(
            visible: visibility,
            child: Positioned(
                top: height*0.05,
                left: width*0.03,
                child: GestureDetector(
                  onTap: ontap,
                  child: Icon(Icons.arrow_back,color: whiteColor,),)),
          ),
        ],
      ),
    );
  }
}
