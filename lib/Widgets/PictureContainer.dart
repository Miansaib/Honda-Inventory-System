import 'package:flutter/material.dart';

import '../Utilities/Colors.dart';
import '../Utilities/Constants.dart';
import '../Utilities/Styles.dart';
class PictureContainer extends StatelessWidget {
  VoidCallback ontap;
  String? imgURL;
  PictureContainer({required this.imgURL,required this.ontap,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        height: height*0.2,
        width: height*0.2,
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(18),
          boxShadow:  [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: imgURL==null?const Center(
          child: Icon(Icons.camera_alt_outlined,size: 30,color:Colors.blueGrey,),
        ):ClipRRect(
          borderRadius: borderRadius,
          child: Image.network(imgURL!, height: height*0.2,
            width: height*0.2,fit: BoxFit.cover
            ,),
        ),
      ),
    );
  }
}

