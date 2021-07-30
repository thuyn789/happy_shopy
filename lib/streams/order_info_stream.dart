import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:happy_shopy/firebase_api/db_services.dart';
import 'package:happy_shopy/screens/order_confirmation_screen/order_info.dart';

class OrderInfoStream extends StatelessWidget {
  OrderInfoStream({required this.orderNumber});

  final String orderNumber;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
        stream: DBServices().orderInfoStream(orderNumber, ''),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: Text("Loading"));
            default:
              if (snapshot.hasError) {
                print(snapshot.error);
                return Center(child: Text('Something went wrong'));
              } else if (snapshot.hasData && !snapshot.data!.exists) {
                return Center(child: Text("This order does not exist"));
              } else if (snapshot.connectionState == ConnectionState.done) {
                final dataObj = snapshot.data!.data() as Map<dynamic, dynamic>;
                return OrderInfo(dataObj: dataObj);
              } else {
                return Center(child: Text('Something went wrong'));
              }
          }
        });
  }
}
