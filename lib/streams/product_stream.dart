import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:happy_shopy/firebase_api/db_services.dart';
import 'package:happy_shopy/screens/home_screen/home_product_item.dart';
import 'package:happy_shopy/screens/manage_product_screen/manage_product_item.dart';

class ProductStream extends StatelessWidget {
  ProductStream({required this.widgetSwitch});

  final int widgetSwitch;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: DBServices().productStream(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Something went wrong'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: Text("Loading"));
          }
          return widgetSwitch == 0 ?
          ListView(
            physics: BouncingScrollPhysics(),
            children:
            snapshot.data!.docs.map((DocumentSnapshot document) {
              final data = document.data() as Map<dynamic, dynamic>;
              return HomeProductItem(dataObj: data);
            }).toList(),
          ):
          ListView(
            physics: BouncingScrollPhysics(),
            children:
            snapshot.data!.docs.map((DocumentSnapshot document) {
              final data = document.data() as Map<dynamic, dynamic>;
              return MangeProductItem(dataObj: data);
            }).toList(),
          );
        });
  }
}
