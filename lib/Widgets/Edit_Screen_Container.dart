import 'package:flutter/material.dart';
import '../Services/Functions/Firebase_Functions.dart';
import '../Services/Functions/ShowAlertDialogFunction.dart';
import '../Services/Models/ProductModel.dart';
import '../Utilities/Colors.dart';
import '../Utilities/Constants.dart';
import '../Utilities/Styles.dart';

class EditScreenContainer extends StatefulWidget {
  ProductModel obj;

  EditScreenContainer({required this.obj, Key? key}) : super(key: key);

  @override
  State<EditScreenContainer> createState() => _EditScreenContainerState();
}

class _EditScreenContainerState extends State<EditScreenContainer> {
  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: height * 0.47,
        width: width * 0.9,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 6,
              offset: Offset(2, 3), // changes position of shadow
            ),
          ],
          color: primaryColor,
          borderRadius: BorderRadius.circular(23),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ClipRRect(
                  borderRadius: borderRadius,
                  child: Image.network(widget.obj.imgURL!,
                      fit: BoxFit.cover,
                      height: height * 0.15,
                      width: width * 0.35, frameBuilder:
                          (context, child, frame, wasSynchronouslyLoaded) {
                    return child;
                  }, loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    } else {
                      return Center(
                        child: CircularProgressIndicator(
                          color: whiteColor,
                        ),
                      );
                    }
                  }),
                ),
                Column(
                  children: [
                    Text(
                      widget.obj.productName,
                      style: textstyle2bold,
                    ),
                    EContainer(
                      containername: 'Rs ',
                      containerData: widget.obj.productPrice,
                      ontap: () {
                        controller.text = widget.obj.productPrice;
                        showAlertDialog(
                            context,
                            controller,
                            Icons.monetization_on_outlined,
                            '',
                            'Product Unit Price',
                            widget.obj.productName);
                        //product name  ,  Field Name  , New Value
                      },
                    ),
                    EContainer(
                      containername: 'Total Parts',
                      containerData: widget.obj.totalParts,
                      ontap: () {
                        controller.text = widget.obj.totalParts;
                        showAlertDialog(
                            context,
                            controller,
                            Icons.production_quantity_limits,
                            '',
                            'Total Quantity of Parts',
                            widget.obj.productName);
                      },
                    ),
                  ],
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                EContainer(
                  containername: 'Remaining Parts',
                  containerData: widget.obj.remainingParts,
                  ontap: () {
                    controller.text = widget.obj.remainingParts;
                    showAlertDialog(
                        context,
                        controller,
                        Icons.electric_moped_sharp,
                        '',
                        'Remaining Parts',
                        widget.obj.productName);
                  },
                ),
                EContainer(
                  containername: 'Total Amount',
                  containerData: widget.obj.totalAmount,
                  ontap: () {
                    controller.text = widget.obj.totalAmount;
                    showAlertDialog(context, controller, Icons.money_off, '',
                        'Total Amount of Parts', widget.obj.productName);
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                EContainer(
                  containername: 'Sold Parts',
                  containerData: widget.obj.soldParts,
                  ontap: () {
                    controller.text = widget.obj.soldParts;
                    showAlertDialog(
                        context,
                        controller,
                        Icons.add_shopping_cart,
                        '',
                        'Sold Units',
                        widget.obj.productName);
                  },
                ),
                EContainer(
                  containername: 'Serial No',
                  containerData: widget.obj.serialNo,
                  ontap: () {
                    controller.text = widget.obj.serialNo;
                    showAlertDialog(context, controller, Icons.numbers, '',
                        'Product ID', widget.obj.productName);
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                EContainer(
                  containername: 'Wholesale Price',
                  containerData: widget.obj.productWholesalePrice,
                  ontap: () {
                    controller.text = widget.obj.productWholesalePrice;
                    showAlertDialog(
                        context,
                        controller,
                        Icons.add_shopping_cart,
                        '',
                        'Product Wholesale Price',
                        widget.obj.productName);
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                    onTap: () {
                      deleteDocument(widget.obj.productName);
                      setState(() {

                      });
                    },
                    child: Icon(
                      Icons.delete_forever,
                      color: whiteColor,
                      size: height * 0.045,
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}

class EContainer extends StatelessWidget {
  String containername, containerData;
  VoidCallback ontap;

  EContainer(
      {required this.ontap,
      required this.containerData,
      required this.containername,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 6,
              offset: Offset(2, 3), // changes position of shadow
            ),
          ],
          color: primaryColor,
          borderRadius: borderRadius,
        ),
        height: height * 0.038,
        width: width * 0.43,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              containername,
              style: textstyle0,
            ),
            Divider(
              color: whiteColor,
              thickness: 50,
              height: 10,
              indent: 20,
            ),
            Text(containerData, style: textstyle0),
            GestureDetector(
              onTap: ontap,
              child: Icon(
                Icons.edit,
                color: whiteColor,
                size: 20,
              ),
            )
          ],
        ),
      ),
    );
  }
}
