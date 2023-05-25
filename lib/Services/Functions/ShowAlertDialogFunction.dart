import 'package:flutter/material.dart';
import 'package:hondainventory/Screens/BillingScreen.dart';
import '../../Utilities/Global_Variables.dart';
import '../../Widgets/AlertDialogBox.dart';

String showAlertDialog(BuildContext context, TextEditingController controller,
    IconData prefixIcon, String hint,String fieldName,productName) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomAlertDialogBox(
          controller: controller,
          prefixIcon: prefixIcon,
          hint: hint, productName: productName, fieldName: fieldName,
        );
      });
  return controller.text;
}
void addBillShowAlertDialog(
    BuildContext context,List<String> productsList) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return BillCustomAlertDialogBox(productList: productsList,);
      });

}
