import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:happy_shopy/firebase_api/db_services.dart';
import 'package:happy_shopy/screens/order_confirmation_screen/order_item.dart';

class OrderItemStream extends StatelessWidget {
  OrderItemStream({required this.orderNumber, required this.userObj});

  final String orderNumber;
  final userObj;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: DBServices().orderItemStream(orderNumber, ''),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Something went wrong'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: Text("Loading"));
          }
          return ListView(
            physics: BouncingScrollPhysics(),
            children:
            snapshot.data!.docs.map((DocumentSnapshot document) {
              if(!document.exists) {
                return Center(child: Text('This order does not exist'));
              }else{
                final data = document.data() as Map<dynamic, dynamic>;
                return OrderItem(dataObj: data, userObj: userObj,);
              }
            }).toList(),
          );
        });
  }
}
