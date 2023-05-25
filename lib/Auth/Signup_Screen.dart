import 'package:flutter/material.dart';

import '../Utilities/Constants.dart';
import '../Widgets/CustomAppBar.dart';
import '../Widgets/Signup_Screen_Container.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: CustomAppBar(
            AppbarIcon: Icons.login_rounded,
            visibility: true, ontap: () { Navigator.of(context).pop(); },
          ),
        ),
        Align(alignment: Alignment.center,child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(height: height*0.01,),
            SignupScreenContainer(),
          ],
        ),),
      ],
    ));
  }
}
