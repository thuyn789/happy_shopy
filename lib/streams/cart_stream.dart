import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:happy_shopy/firebase_api/db_services.dart';
import 'package:happy_shopy/screens/cart_screen/cart_item.dart';

class CartStream extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: DBServices().retrieveCartStream(),
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
              final data = document.data() as Map<dynamic, dynamic>;
              return CartItem(dataObj: data);
            }).toList(),
          );
        });
  }
}
