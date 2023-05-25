import 'package:flutter/material.dart';

import '../Utilities/Colors.dart';
import '../Utilities/Constants.dart';
import '../Utilities/Styles.dart';

class BillProductContainer extends StatelessWidget {
  String tileName, imgURL, price, sNo,discount='0';

  BillProductContainer(
      {required this.tileName, required this.sNo, required this.price, required this.imgURL,required this.discount, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: height*0.1,
        width: width*0.85,
        child: ListTile(

          shape: RoundedRectangleBorder(
            borderRadius: borderRadius
          ),
          trailing: Text('Rs $price - $discount /-',style: textstyle1bold,),
          subtitle: Text('Product ID: $sNo',style: textstyle1,),
          tileColor: primaryColor,
          title:Text(tileName,style: textstyle1bold,),
          textColor: whiteColor,
          leading: SizedBox(
            height: height*0.09,
            width: width*0.2,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(imgURL,height: height*0.09,)),
          ),
        ),
      ),
    );
  }
}
