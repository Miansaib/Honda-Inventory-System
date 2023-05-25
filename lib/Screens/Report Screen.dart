import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:hondainventory/Utilities/Constants.dart';
import 'package:hondainventory/Widgets/CustomAppBar.dart';
import 'package:lottie/lottie.dart';
import '../Services/Functions/Firebase_Functions.dart';
import '../Services/Functions/Report_Filter_Function.dart';
import '../Services/Models/Report_Model.dart';
import '../Utilities/Colors.dart';
import '../Utilities/Styles.dart';
import '../Widgets/BillProductContainer.dart';
import '../Widgets/CusotmFlatButton.dart';
import 'BillingScreen.dart';

class ReportScreen extends StatefulWidget {
  ReportScreen({Key? key}) : super(key: key);

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  List<String> listItems = [
    'Today Report',
    'Weekly Report',
    'Monthly Report',
    'Yearly Report',
    'All Time Report'
  ];

  String? selectedItem = 'Today Report';
bool setstate=true;
  double totalSales = 0,
      totalDiscount = 0,
      totalWholeSale = 0,
      profit = 0;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomAppBar(
              AppbarIcon: Icons.list_alt,
              visibility: true,
              ontap: () {
                Navigator.pop(context);
              }),

          // DropdownButtonHideUnderline(
          //   child: DropdownButton2(
          //     isExpanded: true,
          //     hint: Row(
          //       children: const [
          //         Icon(
          //           Icons.list,
          //           size: 16,
          //           color: Colors.yellow,
          //         ),
          //         SizedBox(
          //           width: 4,
          //         ),
          //         Expanded(
          //           child: Text(
          //             'Select Report',
          //             style: TextStyle(
          //               fontSize: 14,
          //               fontWeight: FontWeight.bold,
          //               color: Colors.yellow,
          //             ),
          //             overflow: TextOverflow.ellipsis,
          //           ),
          //         ),
          //       ],
          //     ),
          //     items: listItems
          //         .map((item) =>
          //         DropdownMenuItem<String>(
          //           value: item,
          //           child: Text(
          //             item,
          //             style: const TextStyle(
          //               fontSize: 14,
          //               fontWeight: FontWeight.bold,
          //               color: Colors.white,
          //             ),
          //             overflow: TextOverflow.ellipsis,
          //           ),
          //         ))
          //         .toList(),
          //     value: selectedItem,
          //     onChanged: (value) {
          //       selectedItem = value as String;
          //       totalDiscount=0;
          //       totalWholeSale=0;
          //       totalSales=0;
          //       profit=0;
          //       setstate=true;
          //       //print(profit);
          //         setState(() {});
          //     },
          //     buttonStyleData: ButtonStyleData(
          //       height: 50,
          //       width: 160,
          //       padding: const EdgeInsets.only(left: 14, right: 14),
          //       decoration: BoxDecoration(
          //         borderRadius: BorderRadius.circular(14),
          //         border: Border.all(
          //           color: Colors.black26,
          //         ),
          //         color: Colors.redAccent,
          //       ),
          //       elevation: 2,
          //     ),
          //     iconStyleData: const IconStyleData(
          //       icon: Icon(
          //         Icons.arrow_forward_ios_outlined,
          //       ),
          //       iconSize: 14,
          //       iconEnabledColor: Colors.yellow,
          //       iconDisabledColor: Colors.grey,
          //     ),
          //     dropdownStyleData: DropdownStyleData(
          //       maxHeight: 250,
          //       width: 200,
          //       padding: null,
          //       decoration: BoxDecoration(
          //         borderRadius: BorderRadius.circular(14),
          //         color: Colors.redAccent,
          //       ),
          //       elevation: 8,
          //       offset: const Offset(-20, 0),
          //       scrollbarTheme: ScrollbarThemeData(
          //         radius: const Radius.circular(40),
          //         thickness: MaterialStateProperty.all<double>(6),
          //         thumbVisibility: MaterialStateProperty.all<bool>(true),
          //       ),
          //     ),
          //     menuItemStyleData: const MenuItemStyleData(
          //       height: 40,
          //       padding: EdgeInsets.only(left: 14, right: 14),
          //     ),
          //   ),
          // ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FlatContainer(value: totalSales.toString(), name: 'Total Sales',),
              FlatContainer(
                value: totalDiscount.toString(), name: 'Total Discount',),

            ],),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FlatContainer(
                value: totalWholeSale.toString(), name: 'Total Whole Sale',),
              FlatContainer(value: profit.toString(), name: 'Profit',),

            ],),
          SizedBox(
            height: height * 0.45,
            width: width,
            child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: FirebaseFirestore.instance.collection('Reports')
                  .snapshots(),
              builder: (_, snapshot) {
                if (snapshot.hasError) return Text('Error = ${snapshot.error}');

                if (snapshot.hasData) {
                  final docs = snapshot.data!.docs;
                  return docs.isNotEmpty ? ListView.builder(

                    scrollDirection: Axis.vertical,
                    itemCount: docs.length,
                    itemBuilder: (_, i) {
                      Product data=Product.fromJson(docs[i].data());
                      if(TimeFrame(selectedItem!, data.datetime)){
                        print(profit);
                          totalSales += double.parse(data.price.toString());
                          totalWholeSale +=
                              double.parse(data.wholesalePrice.toString());
                          totalDiscount +=
                              double.parse(data.discount.toString());
                          return BillProductContainer(
                              tileName: data.name,
                              sNo: data.productId,
                              price: data.price.toString(),
                              imgURL: data.imageUrl,
                              discount: data.discount.toString());
                      }
                      return const SizedBox();}
                  ) : Lottie.asset('Assets/Lottie_Files/nodata.json');
                }
                return const Center(child: CircularProgressIndicator());
                },
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottumBar(
        barName: 'Calculate Total',
        ontap: () {

        //  print(profit);
          if(setstate){

            profit+=((totalSales-totalWholeSale)-totalDiscount);
              setState(() {
                setstate=false;
              });
            }
          },
      )
    );
  }
}


class FlatContainer extends Container {
  String value, name;

  FlatContainer({required this.value, required this.name, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height * 0.08,
      width: width * 0.4,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: primaryColor,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(name, style: textstyle1bold,),

          Text(value, style: textstyle1bold,)
        ],
      ),
    );
  }
}

bool TimeFrame(String selectedItem,String dateTime){
  DateTime timing=DateTime.parse(dateTime);
  DateTime currentTime=DateTime.now();
  if(selectedItem=='Today Report'){
    timing.isAfter(DateTime(currentTime.day));
    print(selectedItem);
    return true;
  }
  else if(selectedItem=='Weekly Report'){
    timing.isAfter(DateTime(DateTime.daysPerWeek));
    print(selectedItem);
    return true;
  }
  else if(selectedItem=='Monthly Report'){
    timing.isAfter(DateTime(currentTime.month));
    print(selectedItem);
    return true;
  }
  else if(selectedItem=='Yearly Report'){
    timing.isAfter(DateTime(currentTime.year));
    print(selectedItem);
    return true;
  }
  else if(selectedItem=='All Time Report'){
    print(selectedItem);
    return true;
  }
  else {
    return false;
  }
}