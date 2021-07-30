import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:happy_shopy/firebase_api/db_services.dart';
import 'package:happy_shopy/screens/cart_screen/cart_info.dart';

class CartInfoStream extends StatelessWidget {
  CartInfoStream({required this.userObj});

  //User Object - A map of DocumentSnapshot
  //Contain user information, name, uid, and email
  final userObj;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
        stream: DBServices().cartInfoStream(),
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
                return Center(child: Text("Please add something to cart"));
              } else if (snapshot.hasData) {
                final dataObj = snapshot.data!.data() as Map<dynamic, dynamic>;
                return CartInfo(dataObj: dataObj, userObj: userObj,);
              } else {
                return Center(child: Text('Something went wrong'));
              }
          }
        });
  }
}