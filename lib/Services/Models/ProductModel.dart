class ProductModel {
  String? imgURL;
  String productName;
  String productPrice;
  String productWholesalePrice;
  String totalParts;
  String remainingParts;
  String totalAmount;
  String soldParts;
  String serialNo;
  String totalDiscount;
  List<dynamic> searchList;

  ProductModel(
      {required this.imgURL,
      required this.productName,
      required this.productPrice,
      required this.totalParts,
      required this.remainingParts,
      required this.totalAmount,
      required this.soldParts,
      required this.serialNo,
      required this.totalDiscount,
      required this.searchList,
      required this.productWholesalePrice});

  static ProductModel fromJSON(Map<String, dynamic> map) {
    return ProductModel(
        imgURL: map['Image URL'],
        productName: map['Product Name'],
        productPrice: map['Product Unit Price'],
        productWholesalePrice: map['Product Wholesale Price'],
        totalParts: map['Total Quantity of Parts'],
        remainingParts: map['Remaining Parts'],
        totalAmount: map['Total Amount of Parts'],
        soldParts: map['Sold Units'],
        totalDiscount: map['Total Discount'],
        serialNo: map['Product ID'],
        searchList: map['Search List']);
  }
}
