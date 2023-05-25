import 'dart:math';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hondainventory/Services/Models/ProductModel.dart';
import 'package:hondainventory/Services/Models/Sell_Product_Model.dart';
import 'package:hondainventory/Widgets/BillProductContainer.dart';
import '../Services/Functions/Firebase_Functions.dart';
import '../Services/Functions/ShowAlertDialogFunction.dart';
import '../Services/Functions/Whatsapp_Launcher.dart';
import '../Services/Models/Report_Model.dart';
import '../Utilities/Colors.dart';
import '../Utilities/Constants.dart';
import '../Utilities/Global_Variables.dart';
import '../Utilities/Styles.dart';
import '../Widgets/BillingScreenContainer.dart';
import '../Widgets/CustomAppBar.dart';
import '../Widgets/RoundedButton.dart';
import 'package:lottie/lottie.dart';

class BillingScreen extends StatefulWidget {
  const BillingScreen({Key? key}) : super(key: key);

  @override
  State<BillingScreen> createState() => _BillingScreenState();
}

class _BillingScreenState extends State<BillingScreen> {
  @override
  void dispose() {
    customerNameController.dispose();
    phoneNumberController.dispose();
    totalBillController.dispose();
    discountController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  TextEditingController customerNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController totalBillController = TextEditingController();
  TextEditingController discountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              CustomAppBar(
                AppbarIcon: Icons.receipt,
                visibility: true,
                ontap: () {
                  Navigator.pop(context);
                },
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RoundedButton(
                      buttonName: 'Generate Bill',
                      ontap: () async {
                        List<List<String>> productsandprice = [];
                        if (customerNameController.text.isNotEmpty &&
                            phoneNumberController.text.isNotEmpty) {
                          int totalBill = 0;
                          for (int i = 0; i < productList.length; i++) {
                            SellProductModel product = productList[i];
                            productsandprice.add([
                              productList[i].productName,
                              productList[i].price
                            ]);
                            totalBill += int.parse(product.price);
                            ProductModel obj =
                                await getDataFromFirestore(product.productName);
                            print(product.productName);
                            //This code is for to update remaining Parts
                            updateValueInFirebase(
                                product.productName,
                                'Remaining Parts',
                                (int.parse(obj.remainingParts) - 1).toString());
                            // //This code is for to update sold parts
                            updateValueInFirebase(
                                product.productName,
                                'Sold Units',
                                (int.parse(obj.soldParts) + 1).toString());
                            // //This code is for to update total amount of parts
                            updateValueInFirebase(
                                product.productName,
                                'Total Amount of Parts',
                                (int.parse(obj.totalAmount) -
                                        int.parse(obj.productPrice))
                                    .toString());
                            // //This code is for to update total amount of parts
                            updateValueInFirebase(
                                product.productName,
                                'Total Quantity of Parts',
                                (int.parse(obj.totalAmount) - 1).toString());
                            // //This code is for to update total discount given to all customer
                            updateValueInFirebase(
                                product.productName,
                                'Total Discount',
                                (int.parse(obj.totalDiscount) +
                                        int.parse(discountController.text))
                                    .toString());
                            final products =
                              Product(
                                  name: obj.productName,
                                  price: double.parse(obj.productPrice),
                                  wholesalePrice: double.parse(obj.productWholesalePrice),
                                  imageUrl: obj.imgURL!,
                                  productId: obj.serialNo, discount: double.parse(productList[i].discount), datetime: DateTime.now().toString());
                            await uploadProduct(products);
                          } // end of loop
                          String billID =
                              (Random().nextInt(900000) + 100000).toString();
                          //This code is to upload bill history to firebase
                          addCustomerData(
                              customerNameController.text,
                              phoneNumberController.text,
                              totalBillController.text,
                              discountController.text,
                              billID,
                              (int.parse(totalBillController.text) -
                                      int.parse(discountController.text))
                                  .toString(),
                              DateTime.now().toString(),
                              divideCaseNumber(billID),
                              productList);
                          // this code will send a msg on whatsapp to customer from your phone

                          print(totalBill);

                          sendWhatsAppMessage(
                              phoneNumberController.text,
                              'Hi ${customerNameController.text}'
                              '\nBill ID:$billID \nYour Total bill is : ${totalBillController.text}'
                              '\nDiscount: ${discountController.text}'
                              '\nBill to be Pay: ${int.parse(totalBillController.text) - int.parse(discountController.text)}'
                              '\nProducts:\n${productsandprice.map((row) => row.join(': ')).join('\n')}');
                          //productList.clear();
                          Fluttertoast.showToast(
                              msg: 'Bill Generated Successfully');
                          Navigator.pop(context);
                        } else {
                          Fluttertoast.showToast(
                              msg: 'Please Fill Required Fields');
                        }
                      }),
                  RoundedButton(
                      buttonName: 'Refresh',
                      ontap: () {
                        int totalBill = 0;
                        int totalDiscount = 0;
                        for (int i = 0; i < productList.length; i++) {
                          final product = productList[i];
                          totalBill += int.parse(product.price);
                          totalDiscount += int.parse(product.discount);
                          totalBillController.text = totalBill.toString();
                          discountController.text = totalDiscount.toString();
                          print(productList.length);
                        }
                        print(productList.length);
                        setState(() {});
                      }),
                ],
              ),
              SizedBox(
                height: height * 0.02,
              ),
              BillingScreenContainer(
                buyerPnumberController: phoneNumberController,
                buyernameController: customerNameController,
                buyerBillNetAmountController: totalBillController,
                TotalBillDiscount: discountController,
              ),
              SizedBox(
                height: height * 0.2,
                width: width,
                child: productList.isNotEmpty
                    ? ListView.builder(
                        itemCount: productList.length,
                        itemBuilder: (BuildContext context, int index) {
                          final product = productList[index];
                          return productList.isNotEmpty ? BillProductContainer(
                            tileName: product.productName,
                            sNo: product.productID,
                            price: product.price,
                            discount: product.discount,
                            imgURL: product.imageURL,
                          ) : Lottie.asset('Assets/Lottie_Files/nodata.json');
                        },
                      )
                    : const SizedBox(),
              ),
            ],
          ),
        ),
        bottomNavigationBar: CustomBottumBar(
          barName: 'Add Product',
          ontap: () async {
            addBillShowAlertDialog(context, await getDocumentNames());
            setState(() {});
          },
        ));
  }
}

class CustomBottumBar extends StatelessWidget {
  String barName;
  VoidCallback ontap;

  CustomBottumBar({required this.barName, required this.ontap, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        height: height * 0.08,
        width: width,
        decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(50), topLeft: Radius.circular(50))),
        child: Center(
          child: Text(
            barName,
            style: textstyle2bold,
          ),
        ),
      ),
    );
  }
}

class ProductContainer extends StatelessWidget {
  const ProductContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height * 0.2,
      width: width * 0.8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
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
    );
  }
}
