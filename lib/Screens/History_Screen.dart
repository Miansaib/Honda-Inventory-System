import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../Services/Models/Bill_History_Model.dart';
import '../Utilities/Constants.dart';
import '../Widgets/CustomAppBar.dart';
import '../Widgets/HistoryScreenContainer.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: CustomAppBar(
              AppbarIcon: Icons.history,
              visibility: true,
              ontap: () {
                Navigator.pop(context);
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              height: height*0.82,
              width: width*0.9,
              child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: FirebaseFirestore.instance.collection('Bill History').snapshots(),
                builder: (_, snapshot) {
                  if (snapshot.hasError) return Text('Error = ${snapshot.error}');

                  if (snapshot.hasData) {
                    final docs = snapshot.data!.docs;
                    return docs.isNotEmpty?ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: docs.length,
                      itemBuilder: (_, i) {
                        final data = docs[i].data();
                        BillHistoryModel obj=BillHistoryModel.fromJSON(data);
                        return HistoryScreenContainer(obj: obj);
                      },
                    ):Lottie.asset('Assets/Lottie_Files/nodata.json');
                  }

                  return Center(child: CircularProgressIndicator());
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
