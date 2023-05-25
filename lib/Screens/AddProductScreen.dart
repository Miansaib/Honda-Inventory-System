import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hondainventory/Services/Functions/Firebase_Functions.dart';
import 'package:hondainventory/Services/Models/ProductModel.dart';
import '../Utilities/Constants.dart';
import '../Widgets/Bottom_Sheet.dart';
import '../Widgets/CustomAppBar.dart';
import '../Widgets/CustomTextField.dart';
import '../Widgets/PictureContainer.dart';
import '../Widgets/RoundedButton.dart';

class AddProductScreen extends StatefulWidget {
  AddProductScreen({Key? key}) : super(key: key);

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  String? imgURL;

  @override
  Widget build(BuildContext context) {
    TextEditingController productNameController = TextEditingController();
    TextEditingController unitPriceController = TextEditingController();
    TextEditingController productTotalAmountController =
        TextEditingController();
    TextEditingController productQuantityController = TextEditingController();
    TextEditingController wholesalePriceController = TextEditingController();
    return Scaffold(
      body: Stack(
        children: [
          CustomAppBar(
            AppbarIcon: Icons.add_box,
            visibility: true,
            ontap: () {
              Navigator.of(context).pop();
            },
          ),
          Align(
            alignment: Alignment.center,
            child: SingleChildScrollView(
              child: Container(
                height: height * 0.8,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: height * 0.1,
                    ),
                    PictureContainer(
                      ontap: () async {
                        imgURL = await showImagePicker(context);
                        setState(() {
                          if (kDebugMode) {
                            print(imgURL);
                          }
                        });
                      },
                      imgURL: imgURL,
                    ),
                    CustomTextField(
                      inputType: TextInputType.name,
                      obsecureText: false,
                      hint: 'Enter Name of Product',
                      controller: productNameController,
                      prefixIcon: Icons.abc,
                    ),
                    CustomTextField(
                      obsecureText: false,
                      hint: 'Enter Unit Price',
                      controller: unitPriceController,
                      prefixIcon: Icons.attach_money,
                      inputType: TextInputType.phone,
                    ),
                    CustomTextField(
                        obsecureText: false,
                        hint: 'Enter Quantity',
                        controller: productQuantityController,
                        prefixIcon: Icons.numbers,
                        inputType: TextInputType.phone),
                    CustomTextField(
                        obsecureText: false,
                        hint: 'Whole Sale Price',
                        controller: wholesalePriceController,
                        prefixIcon: Icons.money,
                        inputType: TextInputType.phone),
                    CustomTextField(
                        onTap: () {
                          productTotalAmountController.text =
                              (int.parse(wholesalePriceController.text) *
                                      int.parse(productQuantityController.text))
                                  .toString();
                        },
                        obsecureText: false,
                        hint: 'Enter Total Amount',
                        controller: productTotalAmountController,
                        prefixIcon: Icons.all_inclusive_outlined,
                        inputType: TextInputType.phone),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: RoundedButton(
              buttonName: 'Add Product',
              ontap: () {
                ProductModel obj = ProductModel(
                    imgURL: imgURL,
                    productName: productNameController.text,
                    productPrice: unitPriceController.text,
                    totalParts: productQuantityController.text,
                    remainingParts:
                        (int.parse(productQuantityController.text) - 0)
                            .toString(),
                    totalAmount: productTotalAmountController.text,
                    soldParts: '0',
                    serialNo: (Random().nextInt(9000) + 1000).toString(),
                    searchList: [], productWholesalePrice: wholesalePriceController.text, totalDiscount: '0');
                uploadNewProductData(obj);
                Fluttertoast.showToast(msg: "Product Added Successfully");
                Navigator.pop(context);
              },
            ),
          )
        ],
      ),
    );
  }
}
