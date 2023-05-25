import 'package:hondainventory/Services/Models/Sell_Product_Model.dart';

class BillHistoryModel {
  String customerName;
  String phoneNo;
  String totalBill;
  String billDiscount;
  String billID;
  String withDiscountAmount;
  String time;
  List<dynamic> searchList = [];
  //List<SellProductModel> boughtProducts = <SellProductModel>[];
  String boughtProducts;
  BillHistoryModel({
    searchList,
    required this.customerName,
    required this.phoneNo,
    required this.totalBill,
    required this.billDiscount,
    required this.billID,
    required this.withDiscountAmount,
    required this.time,
    required this.boughtProducts,
  });

  static BillHistoryModel fromJSON(Map<String, dynamic> map) {
    return BillHistoryModel(
        searchList: map['Search List'],
        customerName: map['Customer Name'],
        phoneNo: map['Phone Number'],
        totalBill: map['Total Bill'],
        billDiscount: map['Total Discount'],
        billID: map['Bill ID'],
        withDiscountAmount: map['Bill To Be Pay'],
        time: map['Date and Time'],
        boughtProducts: map['Products List']);
  }
}
