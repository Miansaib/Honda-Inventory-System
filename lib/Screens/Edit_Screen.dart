import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../Services/Models/ProductModel.dart';
import '../Utilities/Constants.dart';
import '../Widgets/CustomAppBar.dart';
import '../Widgets/Edit_Screen_Container.dart';

class EditScreen extends StatefulWidget {
  const EditScreen({Key? key}) : super(key: key);

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Stack(
        children: [
          CustomAppBar(
            AppbarIcon: Icons.edit_note_outlined,
            visibility: true,
            ontap: () {
              Navigator.of(context).pop();
            },
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              height: height * 0.8,
              width: width,
              child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: FirebaseFirestore.instance.collection('Products').snapshots(),
                builder: (_, snapshot) {
                  if (snapshot.hasError) return Text('Error = ${snapshot.error}');

                  if (snapshot.hasData) {
                    final docs = snapshot.data!.docs;
                    return docs.isNotEmpty ? ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: docs.length,
                      itemBuilder: (_, i) {
                        final data = docs[i].data();
                        ProductModel obj=ProductModel.fromJSON(data);
                        return EditScreenContainer(obj: obj);
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
