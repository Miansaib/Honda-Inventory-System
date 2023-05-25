import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../Services/Functions/Firebase_Functions.dart';
import '../Services/Models/Sell_Product_Model.dart';
import '../Utilities/Colors.dart';
import '../Utilities/Constants.dart';
import '../Utilities/Global_Variables.dart';
import '../Utilities/Styles.dart';
import 'CustomDropDownMenu.dart';
import 'CustomTextField.dart';
import 'RoundedButton.dart';

class CustomAlertDialogBox extends StatefulWidget {
  String hint;
  IconData prefixIcon;
  TextEditingController controller;
  String productName, fieldName;

  CustomAlertDialogBox(
      {required this.controller,
      required this.prefixIcon,
      required this.hint,
      required this.productName,
      required this.fieldName,
      Key? key})
      : super(key: key);

  @override
  State<CustomAlertDialogBox> createState() => _CustomAlertDialogBoxState();
}

class _CustomAlertDialogBoxState extends State<CustomAlertDialogBox> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        backgroundColor: primaryColor,
        content: Container(
          height: height * 0.3,
          width: width * 0.85,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Edit',
                  style: textstyle2bold,
                ),
                CustomTextField(
                    obsecureText: false,
                    hint: widget.hint,
                    controller: widget.controller,
                    prefixIcon: widget.prefixIcon),
                RoundedButton(
                  buttonName: 'Submit',
                  ontap: () {
                    updateValueInFirebase(widget.productName, widget.fieldName,
                        widget.controller.text);
                    Navigator.pop(context);
                  },
                )
              ]),
        ));
    ;
  }
}

class BillCustomAlertDialogBox extends StatefulWidget {
  List<String> productList;

  BillCustomAlertDialogBox({required this.productList, Key? key})
      : super(key: key);

  @override
  State<BillCustomAlertDialogBox> createState() =>
      _BillCustomAlertDialogBoxState();
}

class _BillCustomAlertDialogBoxState extends State<BillCustomAlertDialogBox> {
  @override
  Widget build(BuildContext context) {
    TextEditingController productDiscountController = TextEditingController();
    return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        backgroundColor: primaryColor,
        content: SingleChildScrollView(
          child: Container(
            height: height * 0.6,
            width: width * 0.85,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Add Product to Bill',
                    style: textstyle2bold,
                  ),
                  DropdownButtonHideUnderline(
                    child: DropdownButton2(
                      isExpanded: true,
                      hint: Row(
                        children: const [
                          Icon(
                            Icons.list,
                            size: 16,
                            color: Colors.yellow,
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Expanded(
                            child: Text(
                              'Select Item',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.yellow,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      items: widget.productList
                          .map((item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ))
                          .toList(),
                      value: selectedItem,
                      onChanged: (value) async {
                        selectedItem = value as String;

                        Sno = await getFieldData(selectedItem!, 'Product ID');
                        PPrice = await getFieldData(
                            selectedItem!, 'Product Unit Price');
                        imageURL = await getFieldData(selectedItem!, 'Image URL');
                        wholesalePrice = await getFieldData(selectedItem!, 'Product Wholesale Price');
                        setState(() {});
                      },
                      buttonStyleData: ButtonStyleData(
                        height: 50,
                        width: 160,
                        padding: const EdgeInsets.only(left: 14, right: 14),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: Colors.black26,
                          ),
                          color: Colors.redAccent,
                        ),
                        elevation: 2,
                      ),
                      iconStyleData: const IconStyleData(
                        icon: Icon(
                          Icons.arrow_forward_ios_outlined,
                        ),
                        iconSize: 14,
                        iconEnabledColor: Colors.yellow,
                        iconDisabledColor: Colors.grey,
                      ),
                      dropdownStyleData: DropdownStyleData(
                        maxHeight: 200,
                        width: 200,
                        padding: null,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: Colors.redAccent,
                        ),
                        elevation: 8,
                        offset: const Offset(-20, 0),
                        scrollbarTheme: ScrollbarThemeData(
                          radius: const Radius.circular(40),
                          thickness: MaterialStateProperty.all<double>(6),
                          thumbVisibility: MaterialStateProperty.all<bool>(true),
                        ),
                      ),
                      menuItemStyleData: const MenuItemStyleData(
                        height: 40,
                        padding: EdgeInsets.only(left: 14, right: 14),
                      ),
                    ),
                  ),
                  AlertCContainer(
                      name: selectedItem == null ? 'Serial No' : Sno!),
                  AlertCContainer(
                      name: selectedItem == null
                          ? 'Product Price'
                          : PPrice + ' Rs\\-'),
                  AlertCContainer(
                      name: selectedItem == null ? 'Wholesale Price' : wholesalePrice+' Rs\\-'),
                  CustomTextField(
                      obsecureText: false,
                      hint: 'Discount in Amount',
                      controller: productDiscountController,
                      prefixIcon: Icons.monetization_on_outlined),
                  RoundedButton(
                      buttonName: 'Add',
                      ontap: () {
                        productList.add(SellProductModel(productName:
                        selectedItem!,
                            productID:
                            Sno,
                            discount:productDiscountController.text,
                            price: PPrice,
                            imageURL:
                            imageURL));
                        if (kDebugMode) {
                          print(productList.length);
                          print(productList[0].productName);
                        }
                        Navigator.pop(context,productList);
                      })
                ]),
          ),
        ));
  }
}

class AlertCContainer extends StatelessWidget {
  String name;

  AlertCContainer({required this.name, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: height * 0.07,
        width: width * 0.6,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: primaryColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 6,
              offset: Offset(2, 3), // changes position of shadow
            ),
          ],
        ),
        child: Center(
          child: Text(
            name,
            style: textstyle1,
          ),
        ),
      ),
    );
  }
}
