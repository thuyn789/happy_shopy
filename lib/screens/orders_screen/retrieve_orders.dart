import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:happy_shopy/firebase_api/db_services.dart';
import 'package:happy_shopy/screens/orders_screen/orders_item.dart';

class RetrieveOrders extends StatelessWidget {
  RetrieveOrders({required this.userObj});

  final userObj;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: DBServices().retrieveOrders(''),
      builder:
          (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }
        if (!snapshot.hasData) {
          return Text("Empty");
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return ListView(
            physics: BouncingScrollPhysics(),
            children:
            snapshot.data!.docs.map((DocumentSnapshot document) {
              final data = document.data() as Map<dynamic, dynamic>;
              return OrdersItem(dataObj: data, userObj: userObj,);
            }).toList(),
          );
        }
        return Text("loading");
      },
    );
  }
}
