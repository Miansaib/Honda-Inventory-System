import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hondainventory/Services/Models/Bill_History_Model.dart';
import 'package:intl/intl.dart';
import '../Utilities/Colors.dart';
import '../Utilities/Constants.dart';
import '../Utilities/Styles.dart';

class HistoryScreenContainer extends StatelessWidget {
  BillHistoryModel obj;
  HistoryScreenContainer({required this.obj,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<dynamic> data = json.decode(obj.boughtProducts);
    return Container(
      margin: EdgeInsets.only(top: 10,bottom: 10),
      height: height * 0.65,
      width: width * 0.85,
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('Date '+DateFormat('dd-MMM-yyyy').format(DateTime.parse(obj.time)),style: textstyle1,),
              Text('Time '+DateFormat('HH:mm a').format(DateTime.parse(obj.time)),style: textstyle1,),
            ],
          ),
          HContaienr(name: obj.billID, icon: Icons.directions_boat_filled, containerName: 'Bill ID',),
          HContaienr(name: obj.customerName, icon: Icons.sort_by_alpha, containerName: 'Customer Name',),
          HContaienr(name: obj.phoneNo, icon: Icons.numbers_outlined, containerName: 'Phone Number',),
          HContaienr(name: obj.totalBill.toString(), icon: Icons.money, containerName: 'Total Bill',),
          HContaienr(name: obj.billDiscount.toString(), icon: Icons.numbers_outlined, containerName: 'Bill Discount',),
          HContaienr(name: obj.withDiscountAmount.toString(), icon: Icons.money, containerName: 'Amount to be Pay',),
          SizedBox(
            height: height*0.15,
            width: width*0.6,
            child: ListView.builder(
                physics: ScrollPhysics(),
                itemCount: data.length,
                itemBuilder: (_,i){
              return Padding(
                padding: const EdgeInsets.only(top: 10),
                child: HHContaienr(name: data[i]['productName'], price: data[i]['price']),
              );
            }),
          ),
        ],
      ),
    );
  }
}

class HContaienr extends StatelessWidget {
  String name,containerName;
  IconData icon;

  HContaienr({required this.name,required this.containerName, required this.icon, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height * 0.07,
      width: width * 0.7,
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
      child: Padding(
        padding: const EdgeInsets.only(left: 20,right: 20),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
          Icon(icon,color: whiteColor,),
          Text(containerName,style: textstyle1bold,),
          Text(
            name,
            style: textstyle1,
          )
        ]),
      ),
    );
  }
}

class HHContaienr extends StatelessWidget {
  String name, price;

  HHContaienr({required this.name, required this.price, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height * 0.06,
      width: width * 0.4,
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            name,
            style: textstyle1,
          ),
          Text(
            'Rs '+price+'/-',
            style: textstyle1bold,
          )
        ],
      ),
    );
  }
}
