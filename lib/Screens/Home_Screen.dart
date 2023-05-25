import 'package:flutter/material.dart';
import 'package:hondainventory/Auth/Login_Screen.dart';
import '../Services/Functions/Logout_Function.dart';
import '../Utilities/Constants.dart';
import '../Utilities/Global_Variables.dart';
import '../Widgets/CustomAppBar.dart';
import '../Widgets/HomeScreenContainer.dart';
import '../Widgets/RoundedButton.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    height=MediaQuery.of(context).size.height;
    width=MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: CustomAppBar(
              AppbarIcon: Icons.home_max_outlined,
              visibility: false,
              ontap: () {
                Navigator.pop(context);
              },
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              height: height * 0.8,
              width: width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: height * 0.1,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      HomeScreenContainer(
                        containerIcon: Icons.edit_note_outlined,
                        buttonName: 'Edit',
                        ontap: () {
                          Navigator.pushNamed(context, '/EditScreen');
                        },
                      ),
                      HomeScreenContainer(
                        containerIcon: Icons.add_box_outlined,
                        buttonName: 'Add Product',
                        ontap: () {
                          Navigator.pushNamed(context, '/AddNewStockScreen');
                        },
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      HomeScreenContainer(
                        containerIcon: Icons.history,
                        buttonName: 'History',
                        ontap: () {Navigator.pushNamed(context, '/HistoryScreen');},
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      HomeScreenContainer(
                        containerIcon: Icons.payment_rounded,
                        buttonName: 'Add Bill',
                        ontap: () {Navigator.pushNamed(context, '/BillingScreen');
                          productList=[];
                          },
                      ),
                      HomeScreenContainer(
                        containerIcon: Icons.list_alt,
                        buttonName: 'Reports',
                        ontap: () {
                          Navigator.pushNamed(context, '/ReportScreen');
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: RoundedButton(ontap: () {
              logoutUser(context,LoginScreen());
            }, buttonName: 'Logout'),
          )
        ],
      ),
    );
  }
}
