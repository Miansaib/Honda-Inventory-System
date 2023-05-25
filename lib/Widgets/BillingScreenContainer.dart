import 'package:flutter/material.dart';
import '../Utilities/Colors.dart';
import '../Utilities/Constants.dart';
import 'CustomTextField.dart';

class BillingScreenContainer extends StatelessWidget {
  TextEditingController buyernameController = TextEditingController();
  TextEditingController buyerPnumberController = TextEditingController();
  TextEditingController buyerBillNetAmountController = TextEditingController();
  TextEditingController TotalBillDiscount = TextEditingController();

  BillingScreenContainer(
      {required this.buyerPnumberController,
      required this.buyernameController,
      required this.buyerBillNetAmountController,
      required this.TotalBillDiscount,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height * 0.4,
      width: width * 0.85,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: primaryColor,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CustomTextField(
            obsecureText: false,
            hint: 'Name of Customer',
            inputType: TextInputType.name,
            controller: buyernameController,
            prefixIcon: Icons.person,
          ),
          CustomTextField(
            inputType: TextInputType.phone,
            obsecureText: false,
            hint: 'Phone No',
            controller: buyerPnumberController,
            prefixIcon: Icons.contact_mail,
          ),
          CustomTextField(
            inputType: TextInputType.phone,
            obsecureText: false,
            hint: 'Total Amount',
            controller: buyerBillNetAmountController,
            prefixIcon: Icons.money_outlined,
          ),
          CustomTextField(
            inputType: TextInputType.phone,
            obsecureText: false,
            hint: 'Discount',
            controller: TotalBillDiscount,
            prefixIcon: Icons.percent,
          ),
        ],
      ),
    );
  }
}
